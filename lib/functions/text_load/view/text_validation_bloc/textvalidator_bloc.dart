import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/text_validator.dart';

part 'textvalidator_event.dart';
part 'textvalidator_state.dart';

class TextValidatorBloc extends Bloc<TextValidatorEvent, TextValidatorState> {
  final TextValidator _textValidator;
  TextValidatorBloc(this._textValidator) : super(TextNotValid(''));

  @override
  Stream<TextValidatorState> mapEventToState(
    TextValidatorEvent event,
  ) async* {
    if (event is TextChanged) {
      final String? _result = _textValidator.isValid(event.text);
      yield _result == null ? TextValid() : TextNotValid(_result);
    }
  }
}
