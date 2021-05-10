import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/text_validator.dart';

import '../../../fixtures_parser.dart';

void main() {
  final TextValidatorImpl _textValidatorImpl = TextValidatorImpl();

  final int _numberOfFailTests = 4;
  final int _numberOfPassTest = 4;
  test(
    'should return NOT null for all test texts',
    () async {
      // arrange

      for (int i = 1; i <= _numberOfFailTests; i++) {
        // act
        print(i.toString());
        final String? res =
            _textValidatorImpl.isValid(readFileFail(i.toString()));
        // assert
        expect(res, isNot(null));
      }
    },
  );

  test(
    'should return NULL for all test texts',
    () async {
      // arrange

      for (int i = 1; i <= _numberOfPassTest; i++) {
        // act
        print(i.toString());
        final String? res =
            _textValidatorImpl.isValid(readFileSuccess(i.toString()));
        // assert
        expect(res, null);
      }
    },
  );
}
