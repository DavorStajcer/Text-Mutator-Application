//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_retriver_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_source.dart';

class MockUserDataSource extends Mock implements UserDataSource {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

void main() {
  MockUserDataSource _mockUserDataSource;
  MockConnectionChecker _mockConnectionChecker;
  UserDataRetriverImpl _userDataRetriverImpl;

  setUp(() {
    _mockUserDataSource = MockUserDataSource();
    _mockConnectionChecker = MockConnectionChecker();
    _userDataRetriverImpl = UserDataRetriverImpl(
      _mockUserDataSource,
      _mockConnectionChecker,
    );
  });

  final String _testUsername = 'awsome_user';

  void _arraneUserDataSourceSuccess() {
    when(_mockUserDataSource.getUsername())
        .thenAnswer((_) async => _testUsername);
  }

  void _arraneUserDataSourceFail() {
    when(_mockUserDataSource.getUsername()).thenThrow(UnimplementedError());
  }

  void _arrangeConnection({bool isConnected}) {
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((_) async => isConnected);
  }

  test(
    'should call .getUsername on user datasource',
    () async {
      // arrange

      _arrangeConnection(isConnected: true);
      _arraneUserDataSourceSuccess();
      // act
      await _userDataRetriverImpl.getUsername();
      // assert
      verify(_mockUserDataSource.getUsername()).called(1);
      verifyNoMoreInteractions(_mockUserDataSource);
    },
  );

  test(
    'should return correct username when succes',
    () async {
      // arrange

      _arrangeConnection(isConnected: true);
      _arraneUserDataSourceSuccess();
      // act
      final _username = await _userDataRetriverImpl.getUsername();
      // assert
      expect(_username, Right(_testUsername));
    },
  );

  test(
    'should return ServerFailure when unsuccessfull in getting username',
    () async {
      // arrange
      _arrangeConnection(isConnected: true);
      _arraneUserDataSourceFail();
      // act
      final _username = await _userDataRetriverImpl.getUsername();
      // assert
      expect(_username, Left(ServerFailure()));
    },
  );

  test(
    'should return check if there is connection',
    () async {
      // act
      await _userDataRetriverImpl.getUsername();
      // assert
      verify(_mockConnectionChecker.hasConnection).called(1);
    },
  );

  test(
    'should return NoConnectionFailure when there is no connection',
    () async {
      // arrange
      _arrangeConnection(isConnected: false);
      // act
      final _username = await _userDataRetriverImpl.getUsername();
      // assert
      expect(_username, Left(NoConnetionFailure()));
    },
  );
}
