//@dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/text_validator.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/textvalidator_bloc.dart';

class MockTextValidator extends Mock implements TextValidator {}

void main() {
  MockTextValidator _mockTextValidator;

  setUp(() {
    _mockTextValidator = MockTextValidator();
  });

  final String _testTextForValidity = 'test';
  final String _testNotValidMessage = 'test message';

  blocTest(
    'should emit [TextValid] when text is valid',
    build: () {
      when(_mockTextValidator.isValid(_testTextForValidity)).thenReturn(null);
      return TextValidatorBloc(_mockTextValidator);
    },
    act: (bloc) => bloc.add(TextChanged(_testTextForValidity)),
    expect: () => [TextValid()],
  );

  blocTest(
    'should emit [TextNotValid] when text is valid with right message',
    build: () {
      when(_mockTextValidator.isValid(_testTextForValidity))
          .thenReturn(_testNotValidMessage);
      return TextValidatorBloc(_mockTextValidator);
    },
    act: (bloc) => bloc.add(TextChanged(_testTextForValidity)),
    expect: () => [TextNotValid(_testNotValidMessage)],
  );
}
