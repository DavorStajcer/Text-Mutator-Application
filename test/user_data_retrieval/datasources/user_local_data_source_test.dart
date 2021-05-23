//@dart = 2.9

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/core/local_storage_manager/local_storage_manager.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_local_datasource.dart';

class MockLocalStorageManager extends Mock implements LocalStorageManager {}

void main() {
  MockLocalStorageManager _mockLocalStorageManager;
  UserLocalDataSource _userLocalDataSource;

  setUp(() {
    _mockLocalStorageManager = MockLocalStorageManager();
    _userLocalDataSource = UserLocalDataSource(_mockLocalStorageManager);
  });

  final String _testUsername = 'awsome_user';

  _arrangeRetrieval({bool isSuccess = true}) {
    when(_mockLocalStorageManager.getUsername())
        .thenAnswer((_) async => isSuccess ? _testUsername : null);
  }

  test(
    'should call .getUser on local storage',
    () async {
      // arrange
      _arrangeRetrieval();
      // act
      await _userLocalDataSource.getUsername();
      // assert
      verify(_mockLocalStorageManager.getUsername()).called(1);
      verifyNoMoreInteractions(_mockLocalStorageManager);
    },
  );

  test(
    'should return appropriate username when success',
    () async {
      // arrange
      _arrangeRetrieval();
      // act
      final _res = await _userLocalDataSource.getUsername();
      // assert
      expect(_res, _testUsername);
    },
  );

  test(
    'should return null when failed',
    () async {
      // arrange
      _arrangeRetrieval(isSuccess: false);
      // act
      final _res = await _userLocalDataSource.getUsername();
      // assert
      expect(_res, null);
    },
  );

  test(
    'should call saveUsername when saving ',
    () async {
      // arrange

      // act
      final _res = await _userLocalDataSource.saveUsername(_testUsername);
      // assert
      verify(_mockLocalStorageManager.saveUsername(_testUsername)).called(1);
      verifyNoMoreInteractions(_mockLocalStorageManager);
    },
  );
}
