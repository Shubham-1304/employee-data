import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:employee_data/app/modules/employee/ui/cubit/employee_cubit.dart';
import 'package:employee_data/app/modules/employee/ui/widgets/employee_card.dart';
import 'package:employee_data/utils/asset_resources.dart/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_data/utils/asset_resources.dart/image_resource.dart';
import 'package:employee_data/utils/style_resources/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({required this.topPadding , super.key});

  final double topPadding;

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> _employees = [];
  List<Employee> _currentEmployees = [];
  List<Employee> _previousEmployees = [];
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().getAllEmployees();
  }

  bool isCurrentEmployee(DateTime? tillDate) {
    if (tillDate == null) {
      return true;
    }
    final now = DateTime.now();
    if (tillDate.year < now.year ||
        (tillDate.year == now.year && tillDate.month < now.month) ||
        (tillDate.year == now.year &&
            tillDate.month == now.month &&
            tillDate.day < now.day)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeLoaded) {
          _employees = state.employees;
          _currentEmployees = [];
          _previousEmployees = [];
          for (final _employee in _employees) {
            if (isCurrentEmployee(_employee.tillDate)) {
              _currentEmployees.add(_employee);
            } else {
              _previousEmployees.add(_employee);
            }
          }
        } else if (state is EmployeeActionSuccess && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message!,
                style: Styles.regularStyleXS.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              backgroundColor: CR.textColor,
              action: state.showUndo
                  ? SnackBarAction(
                      label: "Undo",
                      textColor: CR.primaryColor,
                      onPressed: () =>
                          context.read<EmployeeCubit>().undoDelete())
                  : null,
            ),
          );
        }
      },
      builder: (context, state) {
        return _employees.isNotEmpty
            ? CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: widget.topPadding,),
              ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: _currentEmployees.isNotEmpty,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Current employees",
                        style: Styles.semiBold500StyleS
                            .copyWith(color: CR.primaryColor),
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                    itemBuilder: (context, index) => EmployeeCard(
                          employee: _currentEmployees[index],
                          isCurrentEmployee: true,
                        ),
                    separatorBuilder: (context, index) => Divider(
                          height: 1.w,
                          color: CR.borderColor,
                        ),
                    itemCount: _currentEmployees.length),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: _previousEmployees.isNotEmpty,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Previous employees",
                        style: Styles.semiBold500StyleS
                            .copyWith(color: CR.primaryColor),
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                    itemBuilder: (context, index) => EmployeeCard(
                          employee: _previousEmployees[index],
                          isCurrentEmployee: false,
                        ),
                    separatorBuilder: (context, index) => Divider(
                          height: 1.w,
                          color: CR.borderColor,
                        ),
                    itemCount: _previousEmployees.length),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: _employees.isNotEmpty,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Text(
                        "Swipe left to delete",
                        style:
                            Styles.regularStyleXS.copyWith(color: CR.hintColor),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 32.h,
                )),
              ])
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      IR.noEmployeeIcon,
                      width: 261.79.w,
                      height: 218.84.h,
                    ),
                    Text(
                      "No employee records found",
                      style: Styles.semiBold500StyleM,
                    )
                  ],
                ),
              );
      },
    );
  }
}
