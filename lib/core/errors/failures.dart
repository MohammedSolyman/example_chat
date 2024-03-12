// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String failureMessage;
  const Failure({
    required this.failureMessage,
  });
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
