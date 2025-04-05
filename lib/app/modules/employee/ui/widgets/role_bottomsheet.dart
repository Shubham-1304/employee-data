import 'package:employee_data/app/core/enums/role.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleBottomsheet extends StatelessWidget {
  const RoleBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.w),
            topRight: Radius.circular(16.w),
          ),
        ),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.pop(context, Role.values[index].name),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: RichText(
                      text: TextSpan(
                        text: Role.values[index].name,
                        style: Styles.regularStyleS.copyWith(color: CR.textColor),
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
            ),
            separatorBuilder: (context, index) => Divider(
                  height: 1.w,
                  color: CR.borderColor,
                ),
            itemCount: Role.values.length),
      ),
    );
  }
}
