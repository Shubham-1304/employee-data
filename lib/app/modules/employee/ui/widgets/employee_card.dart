import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/screens/employee_details_screen.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({required this.employee, required this.isCurrentEmployee, super.key});

  final Employee employee;
  final bool isCurrentEmployee;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.id!.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss:(direction) async{
        print("delete called");
        context.read<EmployeeCubit>().deleteEmployee(employee.id!);
        return false;
      },
      background: Container(
        color: CR.deleteColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SvgPicture.asset(
          'assets/images/icons/delete_icon.svg',
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => EmployeeDetailsScreen(employee: employee,), )),
        child: Container(
          padding: EdgeInsets.all(16.h),
          width: 1.sw,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: Styles.semiBold500StyleS.copyWith(color: CR.textColor),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                employee.role,
                style: Styles.regularStyleXXS.copyWith(color: CR.hintColor),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                !isCurrentEmployee
                    ? "${DateFormat('d MMM, yyyy').format(employee.fromDate)} - ${DateFormat('d MMM, yyyy').format(employee.tillDate!)}"
                    : "From ${DateFormat('d MMM, yyyy').format(employee.fromDate)}",
                style: Styles.regularStyleXXXS.copyWith(color: CR.hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
