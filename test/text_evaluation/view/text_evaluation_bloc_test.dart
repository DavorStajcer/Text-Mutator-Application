//@dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

void main() {
  final Text _testText = Text(
    textDifficulty: TextDifficulty.Easy,
    id: '',
    text: 'test text',
  );

  final TextEvaluationModel _testTextEvaluationModel =
      TextEvaluationModel(_testText, 1, false, false);

  final int _testTextMutationsChanged = 4;
  final bool _testIncludeConjustionsChanged = true;
  final bool _testIncludeSyncategorematicChanged = true;

  blocTest(
    'should emit TextEvaluationLoaded with right TextEvaluationModel on TextEvaluationStarted event',
    build: () => TextEvaluationBloc(),
    act: (bl) => bl.add(TextEvaluationStarted(_testText)),
    expect: () => [TextEvaluationLoaded(_testTextEvaluationModel)],
  );

  blocTest(
    'should emit TextEvaluationLoaded with right TextEvaluationModel on TextConjuctionsChanged event',
    build: () => TextEvaluationBloc(),
    act: (bl) => bl
      ..add(TextEvaluationStarted(_testText))
      ..add(TextConjuctionsChanged(_testIncludeConjustionsChanged)),
    expect: () => [
      TextEvaluationLoaded(_testTextEvaluationModel),
      TextEvaluationLoaded(_testTextEvaluationModel.copyWith(
          includeConjuctions: _testIncludeConjustionsChanged))
    ],
  );

  blocTest(
    'should emit TextEvaluationLoaded with right TextEvaluationModel on TextSyncategorematicChanged event',
    build: () => TextEvaluationBloc(),
    act: (bl) => bl
      ..add(TextEvaluationStarted(_testText))
      ..add(TextSyncategorematicChanged(_testIncludeSyncategorematicChanged)),
    expect: () => [
      TextEvaluationLoaded(_testTextEvaluationModel),
      TextEvaluationLoaded(_testTextEvaluationModel.copyWith(
        includeSyncategorematic: _testIncludeSyncategorematicChanged,
      ))
    ],
  );
}
