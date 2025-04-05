import 'dart:math';

import 'package:employee_data/app/modules/employee/ui/screens/employee_details_screen.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/appbar.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/employee_list.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});
  static const String routeName = '/employeesScreen';

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final GlobalKey _firstKey = GlobalKey();
  double _firstHeight = 0;

  @override
  void initState() {
    super.initState();
    // Delay height fetch to after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _getFirstHeight());
  }

  void _getFirstHeight() {
    final context = _firstKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      setState(() {
        _firstHeight = box.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CR.backgroundColor,
        body: Stack(
          children: [
            EmployeeList(topPadding: _firstHeight,),
            CustomAppBar(widgetKey: _firstKey, title: "Employee List")
          ],
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(min(8.w,8.h)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const EmployeeDetailsScreen(),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(min(8.w,8.h)),
                color: CR.primaryColor),
            width: min(50.w,50.h),
            height: min(50.w,50.h),
            child: Icon(
              Icons.add,
              size: min(18.w,18.h),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
