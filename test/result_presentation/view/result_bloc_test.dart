//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/result_presentation/domain/repositories/result_respository.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/result_bloc/result_bloc.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

class MockResultRepository extends Mock implements ResultRepository {}

void main() {
  MockResultRepository _mockResultRepository;

  setUp(() {
    _mockResultRepository = MockResultRepository();
  });
  final Word _testCleanWord = CleanWord(word: 'a', index: 0);
  final Word _testMutatedWord = MutatedWord(word: 'b', index: 0);
  final Result _testResult = Result(
    difficulty: 44,
    id: '',
    numberOfMutatedWords: 4,
    numberOfMarkedWords: 4,
    numberOfWrongWords: 0,
  );
  final List<Result> _testResults = [_testResult];
  final MutatedText _testMutatedText = MutatedText([
    _testCleanWord,
  ], [
    _testMutatedWord,
  ], 44);

  group('saving result', () {
    blocTest(
      'should remit [ResultLoading, ReusltLoaded] with right returned result',
      build: () {
        when(_mockResultRepository.saveResult(_testMutatedText))
            .thenAnswer((_) async => Right(_testResult));
        return ResultBloc(_mockResultRepository);
      },
      act: (bloc) => bloc.add(CreateResult(_testMutatedText)),
      expect: () => [ResultLoading(), ResultLoaded(_testResult)],
    );

    blocTest(
      'should remit [ResultLoading,ResultError] with ERROR_NO_CONNECTON message when NoConnectionFailure',
      build: () {
        when(_mockResultRepository.saveResult(_testMutatedText))
            .thenAnswer((_) async => Left(NoConnetionFailure()));
        return ResultBloc(_mockResultRepository);
      },
      act: (bloc) => bloc.add(CreateResult(_testMutatedText)),
      expect: () => [ResultLoading(), ResultError(ERROR_NO_CONNECTION)],
    );

    blocTest(
      'should remit [ResultLoading,ResultError] with ERROR_SERVER_FAILURE message when saving goes wrong',
      build: () {
        when(_mockResultRepository.saveResult(_testMutatedText))
            .thenAnswer((_) async => Left(ServerFailure()));
        return ResultBloc(_mockResultRepository);
      },
      act: (bloc) => bloc.add(CreateResult(_testMutatedText)),
      expect: () => [ResultLoading(), ResultError(ERROR_SERVER_FAILURE)],
    );
  });
}
