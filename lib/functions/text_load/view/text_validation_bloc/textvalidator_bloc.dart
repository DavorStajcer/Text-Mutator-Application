import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'textvalidator_event.dart';
part 'textvalidator_state.dart';

class TextValidatorBloc extends Bloc<TextValidatorEvent, TextValidatorState> {
  TextValidatorBloc() : super(TextNotValid(''));

  @override
  Stream<TextValidatorState> mapEventToState(
    TextValidatorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
