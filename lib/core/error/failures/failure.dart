import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class AllTextsReadFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoConnetionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserDataRetrievalFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserAuthenticationFailure extends Failure {
  final String message;

  UserAuthenticationFailure(this.message);
  @override
  List<Object> get props => [message];
}
