//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/result_presentation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';
import 'package:text_mutator/functions/result_presentation/data/respositories/results_repository_impl.dart';
import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/mutated_text.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';

// class MockDatabaseSource extends Mock implements DatabaseSource {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockNetworkDataSource extends Mock implements NetworkResultDataSource {}

void main() {
  // MockDatabaseSource _mockNetworkDataSource;
  MockConnectionChecker _mockConnectionChecker;
  MockNetworkDataSource _mockNetworkDataSource;
  ResultRepositoryImpl _resultRepositoryImpl;

  setUp(() {
    //_mockDatabaseSource = MockDatabaseSource();
    _mockConnectionChecker = MockConnectionChecker();
    _mockNetworkDataSource = MockNetworkDataSource();
    _resultRepositoryImpl = ResultRepositoryImpl(
      //_mockDatabaseSource,
      _mockConnectionChecker,
      _mockNetworkDataSource,
    );
  });

  final double _testResultDifficulty = 40.0;
  final MutatedText _testMutatedText = MutatedText(
    [
      CleanWord(index: 0, word: 'test')..isSelected = true,
      CleanWord(index: 1, word: 'test')..isSelected = false,
    ],
    [
      MutatedWord(index: 0, word: 'test')..isSelected = false,
      MutatedWord(index: 1, word: 'test')..isSelected = true,
    ],
    _testResultDifficulty,
  );

  final ResultModel _testResultModel =
      ResultModel(2, 1, 2, _testResultDifficulty, 'test');
  final Result _testResult = _testResultModel;

  void _arrangeConnection(bool isConnected) {
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) async => isConnected);
  }

  void _verifyCheckConnection() {
    verify(_mockConnectionChecker.hasConnection).called(1);
    verifyNoMoreInteractions(_mockConnectionChecker);
  }

  // test(
  //   'should calculate correct tesult',
  //   () async {
  //     // act
  //     final res = await _resultRepositoryImpl.calculateResult(_testMutatedText);

  //     // assert
  //     expect(res, equals(_testResult));
  //   },
  // );

  group('Connected', () {
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
        _testResultDifficulty,
        '1',
      ),
      ResultModel(
        1,
        1,
        2,
        _testResultDifficulty,
        '2',
      ),
    ];

    final List<Result> _testResults = _testResultModels;
    final ResultModel _testResultModel = ResultModel(
      1,
      1,
      2,
      _testResultDifficulty,
      '2',
    );

    test(
      'loading should return correct list when success',
      () async {
        // arrange
        _arrangeConnection(true);
        when(_mockNetworkDataSource.fetchResults())
            .thenAnswer((realInvocation) async => _testMapResults);
        // act
        final res = await _resultRepositoryImpl.loadResults();
        // assert
        bool isEqual = listEquals(res.getOrElse(() => null), _testResults);
        expect(isEqual, true);
        verify(_mockNetworkDataSource.fetchResults()).called(1);
        _verifyCheckConnection();
        verifyNoMoreInteractions(_mockNetworkDataSource);
      },
    );

    test(
      'loading should return ServerFailure when exception goes',
      () async {
        // arrange
        _arrangeConnection(true);
        when(_mockNetworkDataSource.fetchResults())
            .thenThrow(UnimplementedError());
        // act
        final res = await _resultRepositoryImpl.loadResults();
        // assert

        expect(res, Left(ServerFailure()));
        verify(_mockNetworkDataSource.fetchResults()).called(1);
        _verifyCheckConnection();
        verifyNoMoreInteractions(_mockNetworkDataSource);
      },
    );

    test(
      'saving should return ServerFailure when exception goes wrong',
      () async {
        // arrange
        _arrangeConnection(true);
        when(_mockNetworkDataSource.saveResult(any))
            .thenThrow(UnimplementedError());
        // act
        final res = await _resultRepositoryImpl.saveResult(_testMutatedText);
        // assert

        expect(res, Left(ServerFailure()));
        _verifyCheckConnection();
      },
    );
  });

  group('not connected', () {
    test(
      'loading should return NoConnectionFailure when not connected to internet',
      () async {
        // arrange
        _arrangeConnection(false);
        // act
        final res = await _resultRepositoryImpl.loadResults();
        // assert
        expect(res, Left(NoConnetionFailure()));
      },
    );

    test(
      'saving should return NoConnectionFailure when not connected to internet',
      () async {
        // arrange
        _arrangeConnection(false);
        // act
        final res = await _resultRepositoryImpl.saveResult(_testMutatedText);
        // assert
        expect(res, Left(NoConnetionFailure()));
      },
    );
  });
}
