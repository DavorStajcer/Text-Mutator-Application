part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoading extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  final AppUser user;

  UserDataLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class UserDataError extends UserDataState {
  final String message;

  UserDataError(this.message);
  @override
  List<Object> get props => [message];
}
