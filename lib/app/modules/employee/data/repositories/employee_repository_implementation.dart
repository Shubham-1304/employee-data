import 'package:dartz/dartz.dart';
import 'package:employee_data/app/core/errors/failure.dart';
import 'package:employee_data/app/core/typedef.dart';
import 'package:employee_data/app/modules/employee/data/datasources/employee_local_datasource.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImplementation implements EmployeeRepository {
  EmployeeRepositoryImplementation(this._localDataSource);

  final EmployeeLocalDataSource _localDataSource;

  @override
  ResultFuture<List<Employee>> getEmployees() async {
    try {
      final result = await _localDataSource.getEmployees();
      print("get employyes $result");
      return Right(result);
    } on Exception catch (exception) {
      print("local db exception: $exception");
      return Left(LocalDBFailure.fromException(exception));
    }
  }

  @override
  ResultFuture<void> addEmployee(Employee employee) async{
    try {
      print("CALLED");
      final result = await _localDataSource.addEmployee(employee);
      return Right(result);
    } on Exception catch (exception) {
      print("local db exception: $exception");
      return Left(LocalDBFailure.fromException(exception));
    }
  }

  @override
  ResultFuture<void> updateEmployee(Employee employee) async{
    try {
      print("CALLED");
      final result = await _localDataSource.updateEmployee(employee);
      return Right(result);
    } on Exception catch (exception) {
      print("local db exception: $exception");
      return Left(LocalDBFailure.fromException(exception));
    }
  }

  @override
  ResultFuture<void> deleteEmployee(int id) async{
    try {
      print("CALLED");
      final result = await _localDataSource.deleteEmployee(id);
      return Right(result);
    } on Exception catch (exception) {
      print("local db exception: $exception");
      return Left(LocalDBFailure.fromException(exception));
    }
  }
}