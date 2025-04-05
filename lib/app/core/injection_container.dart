import 'package:employee_data/app/modules/employee/data/datasources/employee_local_datasource.dart';
import 'package:employee_data/app/modules/employee/data/repositories/employee_repository_implementation.dart';
import 'package:employee_data/app/modules/employee/domain/repositories/employee_repository.dart';
import 'package:employee_data/app/modules/employee/domain/usecases/employee_usecase.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => EmployeeCubit(
        getEmployees: sl(),
        addEmployee: sl(),
        updateEmployee: sl(),
        deleteEmployee: sl(),
        getEmployeeById: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetEmployees(sl()));
  sl.registerLazySingleton(() => GetEmployeeById(sl()));
  sl.registerLazySingleton(() => AddEmployee(sl()));
  sl.registerLazySingleton(() => UpdateEmployee(sl()));
  sl.registerLazySingleton(() => DeleteEmployee(sl()));

  // Repositories
  sl.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImplementation(sl()));

  // Data Source
  sl.registerLazySingleton<EmployeeLocalDataSource>(
      () => EmployeeLocalDataSourceImplementation());

  void disposeDependency() {
    //Bloc
    sl<EmployeeCubit>().close();
  }
}
