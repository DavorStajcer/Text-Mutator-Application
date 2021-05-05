import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/functions/database/database_source.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';
import 'package:text_mutator/functions/result_presentation/data/respositories/results_repository_impl.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';

class MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  MockDatabaseSource _mockDatabaseSource;
  ResultRepositoryImpl _resultRepositoryImpl;

  setUp(() {
    _mockDatabaseSource = MockDatabaseSource();
    _resultRepositoryImpl = ResultRepositoryImpl(_mockDatabaseSource);
  });

  final MutatedText _testMutatedText = MutatedText(
    [
      CleanWord(index: 0, word: 'test')..isSelected = true,
      CleanWord(index: 1, word: 'test')..isSelected = false,
    ],
    [
      MutatedWord(index: 0, word: 'test')..isSelected = false,
      MutatedWord(index: 1, word: 'test')..isSelected = true,
    ],
  );

  final ResultModel _testResultModel = ResultModel(2, 1, 2, 'test');
  final Result _testResult = _testResultModel;

  test(
    'should calculate correct tesult',
    () async {
      // act
      final res = await _resultRepositoryImpl.calculateResult(_testMutatedText);

      // assert
      expect(res, equals(_testResult));
    },
  );

  group('success', () {
    final List<Map<String, dynamic>> _testMapResults = [
      {
        'mutatedWords': 1,
        'wrongWords': 1,
        'numberOfMarkedWords': 2,
        'id': '1',
      },
      {
        'mutatedWords': 1,
        'wrongWords': 1,
        'numberOfMarkedWords': 2,
        'id': '2',
      }
    ];

    final List<ResultModel> _testResultModels = [
      ResultModel(
        1,
        1,
        2,
        '1',
      ),
      ResultModel(
        1,
        1,
        2,
        '2',
      ),
    ];

    final List<Result> _testResults = _testResultModels;

    test(
      'should return correct list when success',
      () async {
        // arrange
        when(_mockDatabaseSource.fetchResults())
            .thenAnswer((realInvocation) async => _testMapResults);
        // act
        final res = await _resultRepositoryImpl.loadResults();
        // assert
        expect(res, Right(_testResults));
        verify(_mockDatabaseSource.fetchResults()).called(1);
        verifyNoMoreInteractions(_mockDatabaseSource);
      },
    );
  });
}
