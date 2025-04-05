import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/appbar.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/employee_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({this.employee, super.key});
  static const String routeName = '/employeeDetailsScreen';

  final Employee? employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                top: 60.h,
                child: EmployeeForm(
                  employee: employee,
                )),
            CustomAppBar(
              title: "Add Employee Details",
              actions: employee != null
                  ? [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<EmployeeCubit>()
                                .deleteEmployee(employee!.id!);
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/images/icons/delete_icon.svg',
                          ),
                        ),
                      )
                    ]
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
