import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.focus,
      this.onChanged,
      this.keyboardType,
      this.prefixText,
      this.hintText,
      this.prefixIcon,
      this.labelText,
      this.suffixWidget,
      this.stackSuffixWidget,
      this.onTapEvent,
      this.readOnly});
  final TextEditingController controller;
  final FocusNode focus;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? hintText;
  final Widget? prefixIcon;
  final String? labelText;
  final Widget? suffixWidget;
  final Widget? stackSuffixWidget;
  final VoidCallback? onTapEvent;
  final bool? readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _focused = false;
  @override
  void initState() {
    super.initState();
    widget.focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.focus.removeListener(_onFocusChange);
  }

  void _onFocusChange() {
    // print("FOCUS CHANGE");
    setState(() {
      _focused = widget.focus.hasFocus ? true : false;
      // print("is Focused: $_focused");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.focus.hasFocus) {
          widget.focus.requestFocus();
          if (widget.onTapEvent != null) {
            widget.onTapEvent!();
          }
        }
      },
      child: Container(
          height: 40.h,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: _focused ? CR.primaryColor : CR.borderColor),
              borderRadius: BorderRadius.circular(1)),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                      visible: widget.prefixIcon != null,
                      child: widget.prefixIcon!),
                  Visibility(
                      visible: widget.prefixIcon != null,
                      child: SizedBox(
                        width: 10.w,
                      )),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: widget.focus.hasFocus,
                      child: TextField(
                        onTap: widget.onTapEvent,
                        keyboardType: widget.keyboardType,
                        readOnly: widget.readOnly ?? false,
                        controller: widget.controller,
                        focusNode: widget.focus,
                        onChanged: widget.onChanged,
                        style:
                            Styles.regularStyleS.copyWith(color: CR.textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.w),
                          hintText: widget.hintText,
                          labelText: widget.labelText,
                          hintStyle: Styles.regularStyleS.copyWith(
                              color: CR.hintColor,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: widget.suffixWidget != null,
                      child: SizedBox(
                        width: 10.w,
                      )),
                  Visibility(
                      visible: widget.suffixWidget != null,
                      child: widget.suffixWidget ?? const SizedBox.shrink()),
                ],
              ),
            ],
          )),
    );
  }
}
