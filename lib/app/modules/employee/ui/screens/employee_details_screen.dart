import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/appbar.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/employee_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({this.employee, super.key});
  static const String routeName = '/employeeDetailsScreen';

  final Employee? employee;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                top: _firstHeight,
                child: EmployeeForm(
                  employee: widget.employee,
                )),
            CustomAppBar(
              widgetKey: _firstKey,
              title: "Add Employee Details",
              actions: widget.employee != null
                  ? [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<EmployeeCubit>()
                                .deleteEmployee(widget.employee!.id!);
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/images/icons/delete_icon.svg',
                          ),
                        ),
                      )
                    ]
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
