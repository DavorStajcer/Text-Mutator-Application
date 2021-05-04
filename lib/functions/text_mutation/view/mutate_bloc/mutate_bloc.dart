import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:text_mutator/functions/text_mutation/domain/enteties/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/enteties/text.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/text_repository.dart';
import 'package:text_mutator/functions/text_mutation/view/text_bloc/text_bloc.dart';

part 'mutate_event.dart';
part 'mutate_state.dart';

class MutateBloc extends Bloc<MutateEvent, MutateState> {
  final MutatedTextRepository _mutatedTextRepository;
  final TextBloc _textBloc;
  StreamSubscription _textBlocSubscription;

  MutateBloc(this._mutatedTextRepository, this._textBloc)
      : super(MutateInitial()) {
    print("CREATED MUTATE BLOC");

    this.add(MutateText(_textBloc.getText, 2));

    _textBlocSubscription = _textBloc.listen((TextState state) {
      if (state is TextLoaded) {
        print("LISTEND TO TextLoaded");
        this.add(MutateText(
          state.text,
          2, //TODO: ADD VARIABLE NUMBER OF MUTATIONS
        ));
      }
    });
  }

  @override
  Stream<MutateState> mapEventToState(
    MutateEvent event,
  ) async* {
    if (event is MutateText) {
      yield MutateLoading();
      await _mutatedTextRepository.mutateText(
          event.text, event.numberOfMutations);
      print("text mutated");
      yield MutateLoaded(_mutatedTextRepository.mutatedTex);
    }
  }

  @override
  Future<void> close() {
    _textBlocSubscription.cancel();
    super.close();
  }
}
