part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();
}

class SaveUserData extends UserDataEvent {
  final AppUser appUser;

  SaveUserData(this.appUser);
  @override
  List<Object> get props => [appUser];
}

class LoadUserData extends UserDataEvent {
  LoadUserData();
  @override
  List<Object> get props => [];
}
