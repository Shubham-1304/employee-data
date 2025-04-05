import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsConfirmButton extends StatelessWidget {
  const DetailsConfirmButton(
      {required this.onCancel,
      required this.onSave,
      this.leadingWidget,
      super.key});

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: CR.backgroundColor,
            height: 4.h,
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              Visibility(visible: leadingWidget != null, child: leadingWidget ?? const SizedBox.shrink(),),
              const Spacer(),
              InkWell(
                onTap: onCancel,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    color: CR.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: Styles.semiBold500StyleXXS.copyWith(
                        color: CR.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                child: Text(
                  'Save',
                  style: Styles.semiBold500StyleXXS.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
