import 'package:employee_data/app/core/typedef.dart';
import 'package:employee_data/app/core/usecases.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/domain/repositories/employee_repository.dart';

class GetEmployees extends UsecaseWithoutParams<List<Employee>> {
  const GetEmployees(this._repository);

  final EmployeeRepository _repository;

  @override
  ResultFuture<List<Employee>> call() async => _repository.getEmployees();
}


class GetEmployeeById extends UsecaseWithParams<Employee,GetEmployeeByIdParams> {
  const GetEmployeeById(this._repository);

  final EmployeeRepository _repository;

  @override
  ResultFuture<Employee> call(GetEmployeeByIdParams params) async => _repository.getEmployeeById(params.id);
}

class GetEmployeeByIdParams {
  const GetEmployeeByIdParams(this.id);

  final int id;
}


class AddEmployee extends UsecaseWithParams<void, AddEmployeeParams> {
  const AddEmployee(this._repository);

  final EmployeeRepository _repository;

  @override
  ResultFuture<void> call(AddEmployeeParams params) async =>
      _repository.addEmployee(params.employee);
}

class AddEmployeeParams {
  const AddEmployeeParams(this.employee);

  final Employee employee;
}


class UpdateEmployee extends UsecaseWithParams<void, UpdateEmployeeParams> {
  const UpdateEmployee(this._repository);

  final EmployeeRepository _repository;

  @override
  ResultFuture<void> call(UpdateEmployeeParams params) async =>
      _repository.updateEmployee(params.employee);
}

class UpdateEmployeeParams {
  const UpdateEmployeeParams(this.employee);

  final Employee employee;
}


class DeleteEmployee extends UsecaseWithParams<void, DeleteEmployeeParams> {
  const DeleteEmployee(this._repository);

  final EmployeeRepository _repository;

  @override
  ResultFuture<void> call(DeleteEmployeeParams params) async =>
      _repository.deleteEmployee(params.employeeId);
}

class DeleteEmployeeParams {
  const DeleteEmployeeParams(this.employeeId);

  final int employeeId;
}
