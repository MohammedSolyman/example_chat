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

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class InvalidCredentialFailure extends Failure {
  const InvalidCredentialFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class AlreadySingedUpFailure extends Failure {
  const AlreadySingedUpFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure({required super.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}
