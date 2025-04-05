import 'package:employee_data/app/modules/employee/ui/screens/employee_details_screen.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/appbar.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/employee_list.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});
  static const String routeName = '/employeesScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CR.backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text("Employee List",style: Styles.semiBold500StyleM.copyWith(color: Colors.white),),
        // ),
        body: Stack(
          children: [
            Positioned.fill(top: 60.h,child: const EmployeeList()),
            const CustomAppBar(title: "Employee List")
          ],
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(8.w),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const EmployeeDetailsScreen(), ));

          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: CR.primaryColor),
            width: 50.w,
            height: 50.w,
            child: Icon(
              Icons.add,
              size: 18.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
