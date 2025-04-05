import 'package:employee_data/app/core/injection_container.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/screens/employee_details_screen.dart';
import 'package:employee_data/app/modules/employee/ui/screens/employees_screen.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => BlocProvider(
        create: (context) => sl<EmployeeCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "roboto",
              ),
          color: CR.primaryColor,
          home: const EmployeesScreen(),
          routes: {
            EmployeeDetailsScreen.routeName: (context)=> const EmployeeDetailsScreen(),
            EmployeesScreen.routeName:(context) => const EmployeesScreen(),
          },
        ),
      ),
    );
  }
}
