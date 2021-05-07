import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

part 'mutate_event.dart';
part 'mutate_state.dart';

class MutateBloc extends Bloc<MutateEvent, MutateState> {
  final MutatedTextRepositoryImpl _mutatedTextRepository;

  MutateBloc(this._mutatedTextRepository) : super(MutateInitial());

  //  this.add(MutateText(_textBloc.getText, 2));

  // _textBlocSubscription = _textBloc.listen((TextState state) {
  //   if (state is TextLoaded) {
  //     print("LISTEND TO TextLoaded");
  //     this.add(MutateText(
  //       state.text,
  //       2,
  //     ));
  //   }
  // });

  @override
  Stream<MutateState> mapEventToState(
    MutateEvent event,
  ) async* {
    if (event is MutateText) {
      yield MutateLoading();
      await _mutatedTextRepository.mutateText(event.textEvaluationModel);
      print("text mutated");
      // yield MutateLoaded();
    } else if (event is UpdateWord) {
      yield MutateLoading();
      _mutatedTextRepository.updateWord(event.word);
      // yield MutateLoaded(_mutatedTextRepository.mutatedTex);
    }
  }
}
