//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_load/domain/repsositories/text_repository.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/text_mutation/domain/repositories/mutated_text_repository.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';

class MockMutatedTextRepository extends Mock implements MutatedTextRepository {}

class MockTextRepository extends Mock implements TextRepository {}

void main() {
  MockMutatedTextRepository _mockMutatedTextRepository;
  MockTextRepository _mockTextRepository;

  setUp(() {
    _mockTextRepository = MockTextRepository();
    _mockMutatedTextRepository = MockMutatedTextRepository();
  });

  final Text _testText = TextModel(
    'test',
    '',
    TextDifficulty.Easy,
  );
  final TextEvaluationModel _testTextEvaluationModel =
      TextEvaluationModel(_testText, 4, false, false);

  final Word _testCleanWord = CleanWord(word: 'a', index: 0);
  final Word _testMutatedWord = MutatedWord(word: 'b', index: 0);

  final Word _testCleanWordChanged = CleanWord(word: 'a', index: 0)
    ..isSelected = true;

  final MutatedText _testMutatedText = MutatedText([
    _testCleanWord,
  ], [
    _testMutatedWord,
  ], 44);
  final MutatedText _testMutatedTextChanged = MutatedText([
    _testCleanWordChanged,
  ], [
    _testMutatedWord,
  ], 44);

  _setupMutatingSuccess() {
    when(_mockMutatedTextRepository.mutateText(_testTextEvaluationModel))
        .thenAnswer((realInvocation) async => Right(_testMutatedText));
  }

  _setupMutatingFail(Failure failure) {
    when(_mockMutatedTextRepository.mutateText(_testTextEvaluationModel))
        .thenAnswer((realInvocation) async => Left(failure));
  }

  _setupSavingSuccess() {
    when(_mockTextRepository.saveText(_testText))
        .thenAnswer((realInvocation) async => Right(null));
  }

  _setupSavingFail(Failure failure) {
    when(_mockTextRepository.saveText(_testText))
        .thenAnswer((realInvocation) async => Left(failure));
  }

  group('success', () {
    blocTest(
      'should emit [MutateLoading,MutateLoaded] with right MutatedTex when success',
      build: () {
        _setupMutatingSuccess();
        _setupSavingSuccess();
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl.add(MutateText(_testTextEvaluationModel)),
      expect: () =>
          [MutateLoading(), MutateLoaded(mutateText: _testMutatedText)],
    );

    blocTest(
      'should emit [MuatetLoading,MutateLoaded] with right MutatedTex when UpdatingWord',
      build: () {
        _setupMutatingSuccess();
        _setupSavingSuccess();
        when(_mockMutatedTextRepository.mutatedText)
            .thenReturn(_testMutatedTextChanged);
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl
        ..add(MutateText(_testTextEvaluationModel))
        ..add(UpdateWord(_testCleanWord)),
      expect: () => [
        MutateLoading(),
        MutateLoaded(mutateText: _testMutatedText),
        MutateLoading(),
        MutateLoaded(mutateText: _testMutatedTextChanged)
      ],
    );
  });

  group('failure', () {
    blocTest(
      'should emit [MutateLoading,MuateError] with message ERROR_SERVER_FAILURE when  saving goes wrong',
      build: () {
        _setupMutatingSuccess();
        _setupSavingFail(ServerFailure());
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl.add(MutateText(_testTextEvaluationModel)),
      expect: () => [MutateLoading(), MutateError(ERROR_SERVER_FAILURE)],
    );

    blocTest(
      'should emit [MutateLoading,MuateError] with message ERROR_NO_CONNECTION when not connested to internet on saving text',
      build: () {
        _setupMutatingSuccess();
        _setupSavingFail(NoConnetionFailure());
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl.add(MutateText(_testTextEvaluationModel)),
      expect: () => [MutateLoading(), MutateError(ERROR_NO_CONNECTION)],
    );

    blocTest(
      'should emit [MutateLoading,MuateError] with message ERROR_SERVER_FAILURE when  fetching mutated words goes wrong',
      build: () {
        _setupMutatingFail(ServerFailure());
        _setupSavingSuccess();
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl.add(MutateText(_testTextEvaluationModel)),
      expect: () => [MutateLoading(), MutateError(ERROR_SERVER_FAILURE)],
    );

    blocTest(
      'should emit [MutateLoading,MuateError] with message ERROR_NO_CONNECTION when not connested to internet on fetching mutated words',
      build: () {
        _setupMutatingFail(NoConnetionFailure());
        _setupSavingSuccess();
        return MutateBloc(_mockMutatedTextRepository, _mockTextRepository);
      },
      act: (bl) => bl.add(MutateText(_testTextEvaluationModel)),
      expect: () => [MutateLoading(), MutateError(ERROR_NO_CONNECTION)],
    );
  });
}
