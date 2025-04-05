part of 'employee_cubit.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  
  const EmployeeLoaded(this.employees);
  
  @override
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;
  
  const EmployeeError(this.message);
  
  @override
  List<Object> get props => [message];
}

class EmployeeActionSuccess extends EmployeeState {
  final String message;
  
  const EmployeeActionSuccess(this.message);
  
  @override
  List<Object> get props => [message];
}

class EmployeeActionFailed extends EmployeeState {
  final String message;
  
  const EmployeeActionFailed(this.message);
  
  @override
  List<Object> get props => [message];
}