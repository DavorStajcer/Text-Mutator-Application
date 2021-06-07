//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/error/exceptions/exceptions.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/text_load/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/data/respositories/text_repository_impl.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
// class MockDatabaseSource extends Mock implements DatabaseSource {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockNetworkDataSource extends Mock implements NetworkTextDataSource {}

void main() {
  MockConnectionChecker _mockConnectionChecker;
  MockNetworkDataSource _mockNetworkDataSource;
  TextRepositoryImpl textRepositoryImpl;

  setUp(() {
    _mockConnectionChecker = MockConnectionChecker();
    _mockNetworkDataSource = MockNetworkDataSource();

    textRepositoryImpl =
        TextRepositoryImpl(_mockConnectionChecker, _mockNetworkDataSource);
  });

  final String _testId = '4';
  final _testTextMap = {'textDifficulty': 0, 'id': _testId, 'text': 'test'};
  final TextModel _testTextModel = TextModel(
    'test',
    _testId,
    TextDifficulty.Easy,
  );
  final Text _testText = _testTextModel;
  final String _testDifficulty = 'easy';

  void _arrangeConnection(bool isConnected) {
    when(_mockNetworkDataSource.fetchSolvedTextIds())
        .thenAnswer((_) async => []);
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) async => isConnected);
  }

  void _verifyCheckConnection() {
    verify(_mockConnectionChecker.hasConnection).called(1);

    verifyNoMoreInteractions(_mockConnectionChecker);
  }

  group('success', () {
    test(
      'should return appropriate text and call fetchText function once',
      () async {
        // arrange
        _arrangeConnection(true);

        when(_mockNetworkDataSource.fetchText(_testDifficulty, []))
            .thenAnswer((realInvocation) async => _testTextMap);
        // act
        final res = await textRepositoryImpl.loadText(_testText.textDifficulty);
        // assert
        expect(res, equals(Right(_testText)));
        verify(_mockNetworkDataSource.fetchSolvedTextIds()).called(1);
        verify(_mockNetworkDataSource.fetchText(_testDifficulty, [])).called(1);
        _verifyCheckConnection();
        verifyNoMoreInteractions(_mockNetworkDataSource);
      },
    );

    test(
      'should call saveText with appropriate text',
      () async {
        //arrange
        _arrangeConnection(true);
        when(_mockNetworkDataSource.saveText(_testTextModel, _testDifficulty))
            .thenAnswer((_) async => _testId);
        // act
        await textRepositoryImpl.saveText(_testTextModel);
        // assert
        verify(_mockNetworkDataSource.saveText(_testTextModel, _testDifficulty))
            .called(1);
        verify(_mockNetworkDataSource.saveSolvedText(_testId)).called(1);
        _verifyCheckConnection();
        verifyNoMoreInteractions(_mockNetworkDataSource);
      },
    );

    group('failures', () {
      test(
        'should return ServerFailure when fetching text goes wrong',
        () async {
          // arrange
          _arrangeConnection(true);

          when(_mockNetworkDataSource.fetchText(_testDifficulty, []))
              .thenThrow(UnimplementedError());
          // act
          final res =
              await textRepositoryImpl.loadText(_testText.textDifficulty);
          // assert
          expect(res, equals(Left(ServerFailure())));
          verify(_mockNetworkDataSource.fetchSolvedTextIds()).called(1);
          verify(_mockNetworkDataSource.fetchText(_testDifficulty, []))
              .called(1);
          _verifyCheckConnection();
          verifyNoMoreInteractions(_mockNetworkDataSource);
        },
      );

      test(
        'should return AllTextReadFailure when AllTextsSolvedExeption is thrown',
        () async {
          // arrange
          _arrangeConnection(true);

          when(_mockNetworkDataSource.fetchText(_testDifficulty, []))
              .thenThrow(AllTextsSolvedException());
          // act
          final res =
              await textRepositoryImpl.loadText(_testText.textDifficulty);
          // assert
          expect(res, equals(Left(AllTextsReadFailure())));
          verify(_mockNetworkDataSource.fetchSolvedTextIds()).called(1);
          verify(_mockNetworkDataSource.fetchText(_testDifficulty, []))
              .called(1);
          _verifyCheckConnection();
          verifyNoMoreInteractions(_mockNetworkDataSource);
        },
      );

      test(
        'should return ServerFailure when saving goes wrong',
        () async {
          _arrangeConnection(true);

          when(_mockNetworkDataSource.saveText(_testTextModel, _testDifficulty))
              .thenThrow(UnimplementedError());
          // act
          final res = await textRepositoryImpl.saveText(_testTextModel);
          // assert
          expect(res, equals(Left(ServerFailure())));
          verify(_mockNetworkDataSource.saveText(
                  _testTextModel, _testDifficulty))
              .called(1);
          verifyNoMoreInteractions(_mockNetworkDataSource);
        },
      );

      test(
        'should return NoConnectionFailure when not connected on loading text',
        () async {
          // arrange
          _arrangeConnection(false);

          // act
          final res =
              await textRepositoryImpl.loadText(_testText.textDifficulty);
          // assert
          expect(res, equals(Left(NoConnetionFailure())));
          _verifyCheckConnection();

          verifyNever(_mockNetworkDataSource.fetchText(_testDifficulty, []));
        },
      );

      test(
        'should return NoConnectionFailure when not connected on saving text',
        () async {
          _arrangeConnection(false);

          // act
          final res = await textRepositoryImpl.saveText(_testTextModel);
          // assert
          expect(res, equals(Left(NoConnetionFailure())));
          _verifyCheckConnection();
          verifyNever(
              _mockNetworkDataSource.saveText(_testTextModel, _testDifficulty));
        },
      );
    });
  });
}
