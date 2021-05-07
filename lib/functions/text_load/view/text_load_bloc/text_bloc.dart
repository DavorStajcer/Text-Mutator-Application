import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_load/domain/repsositories/text_repository.dart';
part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final TextRepository _textRepository;
  TextBloc(this._textRepository) : super(TextInitial()) {
    print("CREATED TEXT BLOC");
  }

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {}
}
