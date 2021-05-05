import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/database/database_source.dart';
import 'package:text_mutator/functions/text_input_and_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_input_and_load/data/respositories/text_repository_impl.dart';
import 'package:text_mutator/functions/text_input_and_load/domain/models/text.dart';

class MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  MockDatabaseSource mockDatabaseSource;
  TextRepositoryImpl textRepositoryImpl;

  setUp(() {
    mockDatabaseSource = MockDatabaseSource();
    textRepositoryImpl = TextRepositoryImpl(mockDatabaseSource);
  });

  final String _testId = '4';
  final _testTextMap = {'name': 'test', 'id': _testId, 'text': 'test'};
  final TextModel _testTextModel = TextModel('test', 'test', _testId);
  final Text _testText = _testTextModel;

  group('success', () {
    test(
      'should return appropriate text and call fetchText function once',
      () async {
        // arrange
        when(mockDatabaseSource.fetchText(_testId))
            .thenAnswer((realInvocation) async => _testTextMap);
        // act
        final res = await textRepositoryImpl.loadText(_testId);
        // assert
        expect(res, equals(Right(_testText)));
        verify(mockDatabaseSource.fetchText(_testId)).called(1);
        verifyNoMoreInteractions(mockDatabaseSource);
      },
    );

    test(
      'should call saveText with appropriate text',
      () async {
        // act
        await textRepositoryImpl.saveText(_testTextModel);
        // assert
        verify(mockDatabaseSource.saveText(_testTextModel)).called(1);
        verifyNoMoreInteractions(mockDatabaseSource);
      },
    );
  });

  group('failures', () {
    test(
      'should return DatabaseFasilure when fetching text goes wrong',
      () async {
        // arrange
        when(mockDatabaseSource.fetchText(_testId))
            .thenThrow(UnimplementedError());
        // act
        final res = await textRepositoryImpl.loadText(_testId);
        // assert
        expect(res, equals(Left(DatabaseFailure())));
        verify(mockDatabaseSource.fetchText(_testId)).called(1);
        verifyNoMoreInteractions(mockDatabaseSource);
      },
    );

    test(
      'should return DatabaseFailure when saving goes wrong',
      () async {
        when(mockDatabaseSource.saveText(_testTextModel))
            .thenThrow(UnimplementedError());
        // act
        final res = await textRepositoryImpl.saveText(_testTextModel);
        // assert
        expect(res, equals(Left(DatabaseFailure())));
        verify(mockDatabaseSource.saveText(_testTextModel)).called(1);
        verifyNoMoreInteractions(mockDatabaseSource);
      },
    );
  });
}
