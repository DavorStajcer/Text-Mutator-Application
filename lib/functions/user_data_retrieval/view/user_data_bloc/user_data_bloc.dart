import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failures/failure.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserDataRepository _userDataRepository;
  UserDataBloc(this._userDataRepository) : super(UserDataInitial());

  @override
  Stream<UserDataState> mapEventToState(
    UserDataEvent event,
  ) async* {
    yield UserDataLoading();
    if (event is LoadUserData) {
      final _resultEither = await _userDataRepository.getUserData();
      yield _resultEither.fold(
        (Failure failure) => UserDataError(_pickErrorMessage(failure)),
        (AppUser userData) => UserDataLoaded(userData),
      );
    } else if (event is SaveUserData) {
      final _resultEither =
          await _userDataRepository.saveUserData(event.appUser);
      yield _resultEither.fold(
        (Failure failure) => UserDataError(_pickErrorMessage(failure)),
        (_) => UserDataLoaded(event.appUser),
      );
    }
  }
}

String _pickErrorMessage(Failure fail) {
  switch (fail.runtimeType) {
    case NoConnetionFailure:
      return ERROR_NO_CONNECTION;
    case UserDataRetrievalFailure:
      return ERROR_RETRIEVING_USER_DATA;
    case ServerFailure:
      return ERROR_SERVER_FAILURE;
    default:
      return ERROR_SERVER_FAILURE;
  }
}
