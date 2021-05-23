import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_validator.dart';

part 'user_data_validator_state.dart';

class UserDataValidatorCubit extends Cubit<UserDataValidatorState> {
  final UserDataValidator _userDataValidator;
  UserDataValidatorCubit(this._userDataValidator)
      : super(UserDataNotValid(null, ''));

  void validateData(AppUser appUser) {
    final String? _validation =
        _userDataValidator.validateUsername(appUser.username);
    emit(_validation == null
        ? UserDataValid(appUser.username)
        : UserDataNotValid(_validation, appUser.username));
  }
}
