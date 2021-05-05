import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_input_and_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_input_and_load/data/respositories/text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/text_input_and_load/view/text_bloc/text_bloc.dart';

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
  //       2, //TODO: ADD VARIABLE NUMBER OF MUTATIONS
  //     ));
  //   }
  // });

  @override
  Stream<MutateState> mapEventToState(
    MutateEvent event,
  ) async* {
    if (event is MutateText) {
      yield MutateLoading(null);
      await _mutatedTextRepository.mutateText(
          event.text, event.numberOfMutations);
      print("text mutated");
      yield MutateLoaded(_mutatedTextRepository.mutatedTex);
    } else if (event is UpdateWord) {
      yield MutateLoading(null);
      _mutatedTextRepository.updateWord(event.word);
      yield MutateLoaded(_mutatedTextRepository.mutatedTex);
    }
  }
}
