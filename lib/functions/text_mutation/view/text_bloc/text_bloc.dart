import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/functions/text_mutation/domain/enteties/text.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/text_repository.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final TextRepository _textRepository;
  TextBloc(this._textRepository) : super(TextInitial()) {
    print("CREATED TEXT BLOC");
  }

  Text get getText => _textRepository.text;

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {
    if (event is ParseToText) {
      yield TextLoading();
      await _textRepository.parseText(event.text);
      // await Future.delayed(Duration(seconds: 2));
      yield TextLoaded(_textRepository.text);
    }
  }
}
