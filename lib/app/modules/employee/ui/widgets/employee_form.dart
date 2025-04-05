import 'package:employee_data/app/core/enums/date_type.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/custom_textfield.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/custom_date_picker.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/details_confirm_button.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/role_bottomsheet.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({this.employee, super.key});

  final Employee? employee;

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _fromDateController;
  late TextEditingController _tillDateController;

  late FocusNode _nameFocus;
  late FocusNode _roleFocus;
  late FocusNode _fromDateFocus;
  late FocusNode _tillDateFocus;
  DateTime selectedFromDate = DateTime.now();
  DateTime? selectedTillDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    _roleController = TextEditingController();
    _roleFocus = FocusNode();
    _fromDateController = TextEditingController(text: "Today");
    _fromDateFocus = FocusNode();
    _tillDateController = TextEditingController();
    _tillDateFocus = FocusNode();
    _prefillData();
  }

  void _prefillData() {
    final Employee? employee = widget.employee;
    final now = DateTime.now();
    if (employee != null) {
      _nameController.text = employee.name;
      _roleController.text = employee.role;
      _fromDateController.text = employee.fromDate.day == now.day &&
              employee.fromDate.month == now.month &&
              employee.fromDate.year == now.year
          ? "Today"
          : DateFormat('d MMM yyyy').format(employee.fromDate);
      if (employee.tillDate != null) {
        _tillDateController.text = employee.tillDate!.day == now.day &&
                employee.tillDate!.month == now.month &&
                employee.tillDate!.year == now.year
            ? "Today"
            : DateFormat('d MMM yyyy').format(employee.tillDate!);
      }
    }
  }

  void _roleBottomsheet(BuildContext context) async {
    String? role = await showModalBottomSheet<String>(
      barrierColor: Colors.black.withOpacity(0.4),
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
      useSafeArea: false,
      context: context,
      builder: (context) => const RoleBottomsheet(),
    );
    if (role != null) {
      _roleController.text = role;
    }
    _roleFocus.unfocus();
  }

  void _showCustomFromDatePicker(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
            },
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              backgroundColor: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: CustomDatePicker(
                  initialDate: selectedFromDate,
                  dateType: DateType.from,
                  onDateSelected: (date) {
                    setState(() {
                      selectedFromDate = date!;
                    });
                    _fromDateController.text =
                        DateFormat('d MMM yyyy').format(selectedFromDate);
                    Navigator.of(context).pop();
                    _fromDateFocus.unfocus();
                  },
                  onCancelled: () {
                    Navigator.of(context).pop();
                    _fromDateFocus.unfocus();
                  },
                  invalidDates: selectedTillDate,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void _showCustomTillDatePicker(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
            },
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              backgroundColor: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomDatePicker(
                initialDate: selectedTillDate,
                dateType: DateType.till,
                onDateSelected: (date) {
                  if (date != null) {
                    setState(() {
                      selectedTillDate = date;
                    });
                    _tillDateController.text =
                        DateFormat('d MMM yyyy').format(selectedTillDate!);
                  } else {
                    selectedTillDate = null;
                    _tillDateController.text = "";
                  }
                  Navigator.of(context).pop();
                  _tillDateFocus.unfocus();
                },
                onCancelled: () {
                  Navigator.of(context).pop();
                  _tillDateFocus.unfocus();
                },
                invalidDates: selectedFromDate,
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        focus: _nameFocus,
                        onChanged: (_) {},
                        hintText: "Employee name",
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: CR.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      CustomTextField(
                        controller: _roleController,
                        focus: _roleFocus,
                        hintText: "Select role",
                        readOnly: true,
                        prefixIcon: const Icon(
                          Icons.work_outline,
                          color: CR.primaryColor,
                        ),
                        suffixWidget: const Icon(
                          Icons.arrow_drop_down,
                          color: CR.primaryColor,
                        ),
                        onTapEvent: () => _roleBottomsheet(context),
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        bool isNarrow = constraints.maxWidth < 150.w;
                        return Flex(
                          direction: isNarrow ? Axis.vertical : Axis.horizontal,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: CustomTextField(
                                controller: _fromDateController,
                                focus: _fromDateFocus,
                                hintText: "Joining Date",
                                readOnly: true,
                                prefixIcon: SvgPicture.asset(
                                  'assets/images/icons/calender_icon.svg',
                                ),
                                onTapEvent: () =>
                                    _showCustomFromDatePicker(context),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Icon(
                                isNarrow
                                    ? Icons.arrow_downward
                                    : Icons.arrow_forward,
                                color: CR.primaryColor,
                              ),
                            ),
                            Flexible(
                              child: CustomTextField(
                                controller: _tillDateController,
                                focus: _tillDateFocus,
                                hintText: "No date",
                                readOnly: true,
                                prefixIcon: SvgPicture.asset(
                                  'assets/images/icons/calender_icon.svg',
                                ),
                                onTapEvent: () =>
                                    _showCustomTillDatePicker(context),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
            DetailsConfirmButton(
                onCancel: () => Navigator.of(context).pop(),
                onSave: () {
                  if (widget.employee != null) {
                    context.read<EmployeeCubit>().updateEmployee(Employee(
                          id: widget.employee!.id,
                          name: _nameController.text,
                          role: _roleController.text,
                          fromDate: selectedFromDate,
                          tillDate: selectedTillDate,
                        ));
                  } else {
                    context.read<EmployeeCubit>().addEmployee(Employee(
                          name: _nameController.text,
                          role: _roleController.text,
                          fromDate: selectedFromDate,
                          tillDate: selectedTillDate,
                        ));
                  }
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
