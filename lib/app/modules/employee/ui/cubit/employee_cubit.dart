import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/domain/usecases/employee_usecase.dart';
import 'package:equatable/equatable.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit({
    required GetEmployees getEmployees,
    required GetEmployeeById getEmployeeById,
    required AddEmployee addEmployee,
    required UpdateEmployee updateEmployee,
    required DeleteEmployee deleteEmployee,
  })  : _getEmployees = getEmployees,
        _getEmployeeById = getEmployeeById,
        _addEmployee = addEmployee,
        _updateEmployee = updateEmployee,
        _deleteEmployee = deleteEmployee,
        super(EmployeeInitial());

  final GetEmployees _getEmployees;
  final GetEmployeeById _getEmployeeById;
  final AddEmployee _addEmployee;
  final UpdateEmployee _updateEmployee;
  final DeleteEmployee _deleteEmployee;

  Timer? _undoTimer;
  // Track if we're in undo state
  bool _isUndoState = false;

  Employee? _lastDeletedEmployee;

  @override
  Future<void> close() {
    _undoTimer?.cancel();
    return super.close();
  }

  Future<void> getAllEmployees() async {
    emit(EmployeeLoading());
    final result = await _getEmployees();
    result.fold((failure) => emit(EmployeeError(failure.message)),
        (employees) => emit(EmployeeLoaded(employees)));
  }

  Future<void> addEmployee(Employee employee) async {
    emit(EmployeeLoading());
    final result = await _addEmployee(AddEmployeeParams(employee));
    result.fold((failure) {
      print('Failed to add employee: $failure');
      emit(EmployeeActionFailed('Failed to add employee: $failure'));
    }, (_) => emit(const EmployeeActionSuccess(message: 'Employee added successfully')));

    getAllEmployees();
  }

  Future<void> updateEmployee(Employee employee) async {
    emit(EmployeeLoading());
    final result = await _updateEmployee(UpdateEmployeeParams(employee));
    result.fold((failure) {
      print('Failed to update employee: $failure');
      emit(EmployeeActionFailed('Failed to update employee: $failure'));
    },
        (_) =>
            emit(const EmployeeActionSuccess(message: 'Employee update successfully')));

    getAllEmployees();
  }

  Future<void> deleteEmployee(int employeeId) async {
    final findEmployee = await _getEmployeeById(GetEmployeeByIdParams(employeeId));
    findEmployee.fold((failure) {
      // print('Failed to delete  employee: $failure');
      emit(EmployeeActionFailed(failure.message));
    }, (employee) async{

    emit(EmployeeLoading());
    final result = await _deleteEmployee(DeleteEmployeeParams(employeeId));
    result.fold((failure) {
      print('Failed to delete  employee: $failure');
      emit(EmployeeActionFailed('Failed to delete  employee: $failure'));
    }, (_) {
      _undoTimer?.cancel();
      _isUndoState = true;
      _lastDeletedEmployee=employee;
      emit(const EmployeeActionSuccess(message: 'Employee data has been deleted', showUndo: true,));
      getAllEmployees();
    });

    _undoTimer = Timer(const Duration(seconds: 5), () {
      if (_isUndoState) {
        emit(const EmployeeActionSuccess());
        _isUndoState = false;
        _lastDeletedEmployee=null;
        // getAllEmployees();
      }
    });

    });

    // getAllEmployees();
  }

  Future<void> undoDelete() async {
    if (_lastDeletedEmployee != null) {
      // Cancel the auto-commit timer
      _undoTimer?.cancel();
      _isUndoState = false;

      emit(EmployeeLoading());
      final result = await _addEmployee(AddEmployeeParams(_lastDeletedEmployee!));
      result.fold((failure) {
        print('Failed to undo delete: $failure');
        emit(EmployeeActionFailed('Failed to undo delete: $failure'));
      },
          (_) =>
              emit(const EmployeeActionSuccess(message: 'Employee deletion undone')));
      getAllEmployees(); // Reload the list
    }
  }

  void dispose() => emit(EmployeeInitial());
}
