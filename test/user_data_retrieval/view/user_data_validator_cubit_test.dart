//@dart = 2.9

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_validator.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_validator_cubit/user_data_validator_cubit.dart';

class MockUserDataValidator extends Mock implements UserDataValidator {}

void main() {
  MockUserDataValidator _mockUserDataValidator;

  final String _testUsername = 'username';
  final AppUser _testUser = AppUser(_testUsername);

  _arrangeDataValidation({String returnValue}) {
    _mockUserDataValidator = MockUserDataValidator();
    when(_mockUserDataValidator.validateUsername(_testUsername))
        .thenReturn(returnValue);
  }

  blocTest(
    'should call validateUsername when validateData is called with right username',
    build: () {
      _arrangeDataValidation(returnValue: null);
      return UserDataValidatorCubit(_mockUserDataValidator);
    },
    act: (cubit) => cubit.validateData(_testUser),
    verify: (_) =>
        verify(_mockUserDataValidator.validateUsername(_testUsername)),
  );

  blocTest(
    'should emit [UserValid] when validation returns null',
    build: () {
      _arrangeDataValidation(returnValue: null);
      return UserDataValidatorCubit(_mockUserDataValidator);
    },
    act: (cubit) => cubit.validateData(_testUser),
    expect: () => [UserDataValid(_testUsername)],
  );

  blocTest(
    'should emit [UserNotValid] when validation returns String with appropriate message',
    build: () {
      _arrangeDataValidation(returnValue: INPUT_USERNAME_LONG);
      return UserDataValidatorCubit(_mockUserDataValidator);
    },
    act: (cubit) => cubit.validateData(_testUser),
    expect: () => [UserDataNotValid(INPUT_USERNAME_LONG, _testUsername)],
  );
}
