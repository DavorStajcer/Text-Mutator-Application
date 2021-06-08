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
import 'package:text_mutator/functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';
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
  final DateTime _testDateTime = DateTime.now();
  final Result _testResult = Result(
    difficulty: 44,
    id: '',
    numberOfMutatedWords: 4,
    numberOfMarkedWords: 4,
    numberOfWrongWords: 0,
    dateOfResult: _testDateTime,
  );
  final List<Result> _testResults = [_testResult];

  blocTest(
    'should remit [ResultsGraphLoading, ResultsGraphLoaded] when loading results goes well',
    build: () {
      when(_mockResultRepository.loadResults())
          .thenAnswer((_) async => Right(_testResults));
      return ResultsGraphBloc(_mockResultRepository);
    },
    act: (bloc) => bloc.add(LoadResults()),
    expect: () => [ResultsGraphLoading(), ResultsGraphLoaded(_testResults)],
  );

  blocTest(
    'should remit [ResultsGraphLoading, ResultsGraphError] with ERROR_NO_CONNECTION when NoConnectionFailure returned',
    build: () {
      when(_mockResultRepository.loadResults())
          .thenAnswer((_) async => Left(NoConnetionFailure()));
      return ResultsGraphBloc(_mockResultRepository);
    },
    act: (bloc) => bloc.add(LoadResults()),
    expect: () =>
        [ResultsGraphLoading(), ResultsGraphError(ERROR_NO_CONNECTION)],
  );

  blocTest(
    'should remit [ResultsGraphLoading, ResultsGraphError] with ERROR_SERVER_FAILURE when ServerFailure returned',
    build: () {
      when(_mockResultRepository.loadResults())
          .thenAnswer((_) async => Left(ServerFailure()));
      return ResultsGraphBloc(_mockResultRepository);
    },
    act: (bloc) => bloc.add(LoadResults()),
    expect: () =>
        [ResultsGraphLoading(), ResultsGraphError(ERROR_SERVER_FAILURE)],
  );
}
