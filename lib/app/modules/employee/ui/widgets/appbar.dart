import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    this.actions,
    super.key,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 428.w,
      height: 60.h,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CR.primaryColor,
        title: Text(
          title,
          style: Styles.semiBold500StyleM.copyWith(color: Colors.white),
        ),
        actions: actions,
      ),
    );
  }
}
