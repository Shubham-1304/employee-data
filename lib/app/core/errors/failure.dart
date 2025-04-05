import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message,});

  final String message;

  @override
  List<Object?> get props => [message];
}

class LocalDBFailure extends Failure {
  const LocalDBFailure({required super.message});

  LocalDBFailure.fromException(Exception exception)
      : this(
          message: exception.toString(),
        );
}