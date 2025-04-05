import 'dart:convert';

import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.role,
    required super.fromDate,
    required super.tillDate,
  });

  // EmployeeModel copyWith({
  //   String? id,
  //   String? name,
  //   String? country,
  //   int? engineCount,
  //   bool? isActive,
  //   List<String>? flickerImages,
  //   double? costPerLaunch,
  //   double? successRatePercent,
  //   String? description,
  //   String? wikipediaLink,
  //   double? heightInFeet,
  //   double? diameterInFeet,
  // }) {
  //   return EmployeeModel(
  //       id: id ?? this.id,
  //       name: name ?? this.name,
  //       country: country ?? this.country,
  //       costPerLaunch: costPerLaunch ?? this.costPerLaunch,
  //       description: description ?? this.description,
  //       diameterInFeet: diameterInFeet ?? this.diameterInFeet,
  //       engineCount: engineCount ?? this.engineCount,
  //       flickerImages: flickerImages ?? this.flickerImages,
  //       isActive: isActive ?? this.isActive,
  //       heightInFeet: heightInFeet ?? this.heightInFeet,
  //       successRatePercent: successRatePercent ?? this.successRatePercent,
  //       wikipediaLink: wikipediaLink ?? this.wikipediaLink);
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate.millisecondsSinceEpoch,
      'tillDate': tillDate?.millisecondsSinceEpoch
    };
  }

  factory EmployeeModel.fromLocalMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      role: map['role'] as String,
      fromDate:DateTime.fromMillisecondsSinceEpoch(map['fromDate']),
      tillDate: map['tillDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['tillDate']): null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromLocalJson(String source) =>
      EmployeeModel.fromLocalMap(json.decode(source) as Map<String, dynamic>);

  factory EmployeeModel.fromEmployee(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      name: employee.name,
      role: employee.role,
      fromDate: employee.fromDate,
      tillDate: employee.tillDate,
    );
  }

  Employee toEntityType() {
    return Employee(
      id: id,
      name: name,
      role: role,
      fromDate: fromDate,
      tillDate: tillDate,
    );
  }
}
