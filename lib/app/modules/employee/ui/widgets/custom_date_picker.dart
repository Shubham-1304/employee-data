import 'package:employee_data/app/core/enums/date_type.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/details_confirm_button.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    this.initialDate,
    required this.onDateSelected,
    required this.onCancelled,
    required this.dateType,
    this.invalidDates,
    super.key,
  });

  final DateTime? initialDate;
  final Function(DateTime?) onDateSelected;
  final VoidCallback onCancelled;
  final DateType? dateType;
  final DateTime? invalidDates;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
      _currentMonth = DateTime(_selectedDate!.year, _selectedDate!.month, 1);
    } else {
      _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    }
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  bool isDateValid(DateTime date) {
    return (widget.invalidDates == null) ||
        (widget.dateType == DateType.from
            ? (date.year < widget.invalidDates!.year) ||
                (date.year == widget.invalidDates!.year &&
                    date.month < widget.invalidDates!.month) ||
                (date.year == widget.invalidDates!.year &&
                    date.month == widget.invalidDates!.month &&
                    date.day < widget.invalidDates!.day)
            : (date.year > widget.invalidDates!.year) ||
                (date.year == widget.invalidDates!.year &&
                    date.month > widget.invalidDates!.month) ||
                (date.year == widget.invalidDates!.year &&
                    date.month == widget.invalidDates!.month &&
                    date.day > widget.invalidDates!.day));
  }

  List<Widget> _buildQuickSelectFromButtons() {
    final now = DateTime.now();
    final nextMonday = now.add(Duration(days: (8 - now.weekday) % 7));
    final nextTuesday = now.add(Duration(days: (9 - now.weekday) % 7));
    final oneWeekLater = now.add(const Duration(days: 7));

    return [
      Row(
        children: [
          Expanded(
            child: _buildQuickSelectButton('Today', now),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildQuickSelectButton('Next Monday', nextMonday),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _buildQuickSelectButton('Next Tuesday', nextTuesday),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildQuickSelectButton('After 1 week', oneWeekLater),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildQuickSelectTillButtons() {
    final now = DateTime.now();

    return [
      Row(
        children: [
          Expanded(
            child: _buildQuickSelectButton('No date', null),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildQuickSelectButton('Today', now),
          ),
        ],
      ),
    ];
  }

  Widget _buildQuickSelectButton(String text, DateTime? date) {
    bool validDate = true;
    bool isSelected;
    if (date != null) {
      isSelected = date.year == _selectedDate?.year &&
          date.month == _selectedDate?.month &&
          date.day == _selectedDate?.day;
      validDate = isDateValid(date);
    } else {
      isSelected = _selectedDate == null;
    }
    return InkWell(
      onTap: () {
        if (!validDate) {
          return;
        }
        if (date != null) {
          setState(() {
            _selectedDate = date;
            _currentMonth = DateTime(date.year, date.month, 1);
          });
        } else {
          setState(() {
            _selectedDate = null;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: validDate
              ? isSelected
                  ? CR.primaryColor
                  : CR.secondaryColor
              : CR.borderColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.regularStyleXXS.copyWith(
              color: !validDate
                  ? CR.textColor
                  : isSelected
                      ? Colors.white
                      : CR.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    bool invalidNextMonth = widget.dateType == DateType.from &&
        widget.invalidDates != null &&
        (_currentMonth.year > widget.invalidDates!.year ||
            (_currentMonth.year == widget.invalidDates!.year &&
                _currentMonth.month == widget.invalidDates!.month));
    bool invalidPrevMonth = widget.dateType == DateType.till &&
        widget.invalidDates != null &&
        (_currentMonth.year < widget.invalidDates!.year ||
            (_currentMonth.year == widget.invalidDates!.year &&
                _currentMonth.month == widget.invalidDates!.month));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: invalidPrevMonth ? null : _previousMonth,
          icon: Icon(
            Icons.arrow_left,
            color: invalidPrevMonth ? CR.borderColor : CR.hintColor,
            size: 32.sp,
          ),
        ),
        Container(
          constraints: BoxConstraints(
              minWidth: 130
                  .w), //added this constraint so that icons on side doesn't shift their positions
          alignment: Alignment.center,
          child: Text(DateFormat('MMMM yyyy').format(_currentMonth),
              style: Styles.semiBold500StyleM.copyWith(color: CR.textColor)),
        ),
        IconButton(
          onPressed: invalidNextMonth ? null : _nextMonth,
          icon: Icon(
            Icons.arrow_right,
            color: invalidNextMonth ? CR.borderColor : CR.hintColor,
            size: 32.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildDayNames() {
    final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: dayNames
          .map((name) => Expanded(
                child: Center(
                  child: Text(
                    name,
                    style: Styles.regularStyleXS.copyWith(color: CR.textColor),
                  ),
                ),
              ))
          .toList(),
    );
  }

  List<Widget> _buildCalendarDays() {
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7;

    final days = <Widget>[];

    // Add empty cells for days before the start of the month
    for (int i = 0; i < firstDayOfMonth; i++) {
      days.add(const Expanded(child: SizedBox()));
    }

    // Add cells for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final isSelected = date.year == _selectedDate?.year &&
          date.month == _selectedDate?.month &&
          date.day == _selectedDate?.day;

      bool isCurrent = date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day;

      bool isValid = (widget.invalidDates == null) ||
          (widget.dateType == DateType.from
              ? (date.year < widget.invalidDates!.year) ||
                  (date.year == widget.invalidDates!.year &&
                      date.month < widget.invalidDates!.month) ||
                  (date.year == widget.invalidDates!.year &&
                      date.month == widget.invalidDates!.month &&
                      date.day < widget.invalidDates!.day)
              : (date.year > widget.invalidDates!.year) ||
                  (date.year == widget.invalidDates!.year &&
                      date.month > widget.invalidDates!.month) ||
                  (date.year == widget.invalidDates!.year &&
                      date.month == widget.invalidDates!.month &&
                      date.day > widget.invalidDates!.day));

      days.add(
        Expanded(
          child: GestureDetector(
            onTap: (!isValid)
                ? null
                : () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
            child: Container(
              margin: EdgeInsets.all(6.h),
              padding: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                  color: isSelected ? CR.primaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: (isCurrent && isValid)
                          ? CR.primaryColor
                          : Colors.transparent,
                      width: 1)),
              child: Center(
                child: Text(
                  day.toString(),
                  style: Styles.regularStyleXS.copyWith(
                      color: !isValid
                          ? CR.borderColor
                          : isSelected
                              ? Colors.white
                              : isCurrent
                                  ? CR.primaryColor
                                  : CR.textColor),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Calculate rows needed
    final rowCount = ((firstDayOfMonth + daysInMonth) / 7).ceil();
    if (rowCount < 6) {
      for (int i = 0; i < (8 - (firstDayOfMonth + daysInMonth) % 7); i++) {
        days.add(Expanded(
            child: Container(
          margin: EdgeInsets.all(6.h),
          padding: EdgeInsets.all(4.h),
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.transparent, width: 1)),
          child: Center(
            child: Text("0",
                style:
                    Styles.regularStyleXS.copyWith(color: Colors.transparent)),
          ),
        )));
      }
    }
    final rows = <Widget>[];

    for (int i = 0; i < 6; i++) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < 7; j++) {
        final index = i * 7 + j;
        if (index < days.length) {
          rowChildren.add(days[index]);
        } else {
          rowChildren.add(const Expanded(child: SizedBox()));
        }
      }
      rows.add(
        Row(children: rowChildren),
      );
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...(widget.dateType == DateType.from
                ? _buildQuickSelectFromButtons()
                : _buildQuickSelectTillButtons()),
            SizedBox(height: 20.h),
            _buildCalendarHeader(),
            const SizedBox(height: 10),
            _buildDayNames(),
            const SizedBox(height: 10),
            ..._buildCalendarDays(),
            const SizedBox(height: 12),
            DetailsConfirmButton(
              onCancel: widget.onCancelled,
              onSave: () => widget.onDateSelected(_selectedDate),
              leadingWidget: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/calender_icon.svg',
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _selectedDate != null
                        ? DateFormat('d MMM yyyy').format(_selectedDate!)
                        : "No date",
                    style: Styles.regularStyleS.copyWith(color: CR.textColor),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: CR.backgroundColor,
            //   height: 2.h,
            // ),
            // Row(
            //   children: [
            //     SvgPicture.asset(
            //       'assets/images/icons/calender_icon.svg',
            //     ),
            //     const SizedBox(width: 10),
            //     Text(
            //       _selectedDate != null
            //           ? DateFormat('d MMM yyyy').format(_selectedDate!)
            //           : "No date",
            //       style: Styles.regularStyleS.copyWith(color: CR.textColor),
            //     ),
            //     const Spacer(),
            //     InkWell(
            //       onTap: widget.onCancelled,
            //       child: Container(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            //         decoration: BoxDecoration(
            //           color: CR.secondaryColor,
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         child: Center(
            //           child: Text(
            //             "Cancel",
            //             style: Styles.semiBold500StyleXXS.copyWith(
            //               color: CR.primaryColor,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     ElevatedButton(
            //       onPressed: () {
            //         widget.onDateSelected(_selectedDate);
            //         // Navigator.of(context).pop();
            //       },
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.blue,
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 21.w, vertical: 12.h),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(6),
            //           )),
            //       child: Text(
            //         'Save',
            //         style:
            //             Styles.semiBold500StyleXXS.copyWith(color: Colors.white),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
