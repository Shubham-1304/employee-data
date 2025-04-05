import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    this.widgetKey,
    this.actions,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final GlobalKey? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 428.w,
      // height: 60.h,
      child: AppBar(
        key: widgetKey,
        automaticallyImplyLeading: false,
        backgroundColor: CR.primaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: Styles.semiBold500StyleM.copyWith(color: Colors.white),
          ),
        ),
        actions: actions,
      ),
    );
  }
}
