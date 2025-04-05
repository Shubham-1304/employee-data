import 'package:employee_data/app/core/typedef.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';

abstract class EmployeeRepository{
  const EmployeeRepository();

  ResultFuture<List<Employee>> getEmployees();
  ResultFuture<Employee> getEmployeeById(int id);
  ResultFuture<void> addEmployee(Employee employee);
  ResultFuture<void> updateEmployee(Employee employee);
  ResultFuture<void> deleteEmployee(int id);


}