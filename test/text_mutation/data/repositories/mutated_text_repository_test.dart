//@dart=2.9

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_load/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_mutation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockNetworkMutatedWordsSource extends Mock
    implements NetworkMutatedWordsSource {}

class MockRandom extends Mock implements Random {}

class MockedNetworkTextSource extends Mock implements NetworkTextDataSource {}

void main() {
  MockConnectionChecker _mockConnectionChecker;
  MockNetworkMutatedWordsSource _mockNetworkMutatedWordsSource;
  MutatedTextRepositoryImpl _mutatedTextRepository;
  MockRandom _mockRandom;
  setUp(() {
    _mockConnectionChecker = MockConnectionChecker();
    _mockNetworkMutatedWordsSource = MockNetworkMutatedWordsSource();
    _mockRandom = MockRandom();

    _mutatedTextRepository = MutatedTextRepositoryImpl(
      _mockConnectionChecker,
      _mockNetworkMutatedWordsSource,
      _mockRandom,
    );
  });

  void _arrangeConnection(bool isConnected) {
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) async => isConnected);
  }

  void _verifyCheckConnection() {
    verify(_mockConnectionChecker.hasConnection).called(1);
    verifyNoMoreInteractions(_mockConnectionChecker);
  }

  // final MutatedText _testMutatedText =
  //     MutatedText([CleanWord(index: 4, word: '')], []);
  final List<CleanWord> _testCleanWords = [
    CleanWord(word: 'Test', index: 0),
    CleanWord(word: 'words', index: 1),
  ];
  final String _testCleanText = 'Test words';
  final int _testNumberOfMutations = 4;
  final String _testTextToMutate = 'Test text to mutate';

  final Text _testText =
      Text.createDifficulty(text: _testTextToMutate, id: 'test');
  final TextEvaluationModel _testTextEvaluationModel = TextEvaluationModel(
    _testText,
    _testNumberOfMutations,
    true,
    true,
  );

  test(
    'should parse text to list of clean words',
    () async {
      // arrange

      // act
      final words = _mutatedTextRepository.parseText(_testCleanText);
      // assert
      expect(words, equals(_testCleanWords));
    },
  );

  test(
    'should return ServerFialure when fetching words goes wrong',
    () async {
      // arrange
      _arrangeConnection(true);
      when(_mockNetworkMutatedWordsSource.getWords(_testNumberOfMutations))
          .thenThrow(UnimplementedError());
      // act
      final res =
          await _mutatedTextRepository.mutateText(_testTextEvaluationModel);
      // assert
      expect(res, equals(Left(ServerFailure())));
      _verifyCheckConnection();
    },
  );

  test(
    'should return NoConnectionFailure when not connected to internet while mutating text',
    () async {
      // arrange
      _arrangeConnection(false);

      // act
      final res =
          await _mutatedTextRepository.mutateText(_testTextEvaluationModel);
      // assert
      expect(res, equals(Left(NoConnetionFailure())));
      _verifyCheckConnection();
    },
  );

  // test(
  //   'should try to save solved text with correct text id',
  //   () async {
  //     // arrange
  //     _arrangeConnection(true);
  //     when(_mockedNetworkTextSource
  //             .saveSolvedText(_testTextEvaluationModel.text.id))
  //         .thenAnswer((_) async => null);
  //     // act
  //     final res =
  //         await _mutatedTextRepository.saveSolvedText(_testTextEvaluationModel);
  //     // assert
  //     verify(_mockedNetworkTextSource
  //             .saveSolvedText(_testTextEvaluationModel.text.id))
  //         .called(1);
  //     _verifyCheckConnection();
  //   },
  // );

  // test(
  //   'should return NoConnectionFailure when not connected to internet while saving solved text',
  //   () async {
  //     // arrange
  //     _arrangeConnection(false);

  //     // act
  //     final res =
  //         await _mutatedTextRepository.saveSolvedText(_testTextEvaluationModel);
  //     // assert
  //     expect(res, equals(Left(NoConnetionFailure())));
  //     _verifyCheckConnection();
  //   },
  // );

  // test(
  //   'should return ServerFailure when saving solved text goes wrong',
  //   () async {
  //     // arrange
  //     _arrangeConnection(true);
  //     when(_mockedNetworkTextSource
  //             .saveSolvedText(_testTextEvaluationModel.text.id))
  //         .thenThrow(UnimplementedError());
  //     // act
  //     final res =
  //         await _mutatedTextRepository.saveSolvedText(_testTextEvaluationModel);
  //     // assert
  //     expect(res, equals(Left(ServerFailure())));
  //     _verifyCheckConnection();
  //   },
  // );
}
