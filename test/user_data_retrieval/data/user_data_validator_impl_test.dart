//@dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_validator_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_validator_cubit/user_data_validator_cubit.dart';

void main() {
  UserDataValidatorImpl _userDataValidatorImpl;

  setUp(() {
    _userDataValidatorImpl = UserDataValidatorImpl();
  });

  final String _testUsernameLong = 'abababababa';
  final String _testUsernameShort = 'ab';
  final String _testUsernameGood = 'username';

  test(
    'should return INPUT_USERNAME_LONG when username is too long',
    () async {
      // arrange
      final _res = _userDataValidatorImpl.validateUsername(_testUsernameLong);

      // assert

      expect(_res, INPUT_USERNAME_LONG);
    },
  );

  test(
    'should return INPUT_USERNAME_SHORT when username is too short',
    () async {
      // arrange
      final _res = _userDataValidatorImpl.validateUsername(_testUsernameShort);

      // assert

      expect(_res, INPUT_USERNAME_SHORT);
    },
  );

  test(
    'should return null when username is valid',
    () async {
      // arrange
      final _res = _userDataValidatorImpl.validateUsername(_testUsernameGood);

      // assert

      expect(_res, null);
    },
  );
}
