import 'package:bloc/bloc.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/domain/usecases/employee_usecase.dart';
import 'package:equatable/equatable.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit({
    required GetEmployees getEmployees,
    required AddEmployee addEmployee,
    required UpdateEmployee updateEmployee,
    required DeleteEmployee deleteEmployee,
  })  : _getEmployees = getEmployees,
        _addEmployee = addEmployee,
        _updateEmployee = updateEmployee,
        _deleteEmployee = deleteEmployee,
        super(EmployeeInitial());

  final GetEmployees _getEmployees;
  final AddEmployee _addEmployee;
  final UpdateEmployee _updateEmployee;
  final DeleteEmployee _deleteEmployee;

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
    },
        (_) =>
            emit(const EmployeeActionSuccess('Employee added successfully')));

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
            emit(const EmployeeActionSuccess('Employee update successfully')));

    getAllEmployees();
  }

  Future<void> deleteEmployee(int employeeId) async {
    emit(EmployeeLoading());
    final result = await _deleteEmployee(DeleteEmployeeParams(employeeId));
    result.fold((failure) {
      print('Failed to delete  employee: $failure');
      emit(EmployeeActionFailed('Failed to delete  employee: $failure'));
    },
        (_) =>
            emit(const EmployeeActionSuccess('Employee deleted successfully')));

    getAllEmployees();
  }

  void dispose() => emit(EmployeeInitial());
}
