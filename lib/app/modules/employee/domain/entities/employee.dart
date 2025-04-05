import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  const Employee({
    this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    this.tillDate,
  });

  final int? id;
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? tillDate;



  @override
  List<Object?> get props => [id];
}
