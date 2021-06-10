//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/error/exceptions/exceptions.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_web_datasource.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_retriver_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';

class MockUserWebDataSource extends Mock implements UserWebDataSource {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

void main() {
  MockUserWebDataSource _mockUserWebDataSource;
  MockConnectionChecker _mockConnectionChecker;
  UserDataRetriverImpl _userDataRetriverImpl;

  setUp(() {
    _mockUserWebDataSource = MockUserWebDataSource();
    _mockConnectionChecker = MockConnectionChecker();
    _userDataRetriverImpl =
        UserDataRetriverImpl(_mockUserWebDataSource, _mockConnectionChecker);
  });

  final String _testUsername = 'awsome_user';
  final AppUser _testUser = AppUser(_testUsername);

  void _arrangeConnection({bool isConnected = true}) {
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((_) async => isConnected);
  }

  group('loading user data, ', () {
    void _arraneLoadUserWebDataSourceSuccess() {
      when(_mockUserWebDataSource.getUsername())
          .thenAnswer((_) async => _testUsername);
    }

    void _arraneLoadUserWebDataSourceFail() {
      when(_mockUserWebDataSource.getUsername()).thenAnswer((_) async => null);
    }

    test(
      'should return check if there is connection',
      () async {
        // act
        await _userDataRetriverImpl.getUserData();
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
        final _username = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_username, Left(NoConnetionFailure()));
      },
    );

    test(
      'should return correct user  when success',
      () async {
        // arrange
        _arrangeConnection(isConnected: true);
        _arraneLoadUserWebDataSourceSuccess();
        // act
        final _username = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_username, Right(_testUser));
      },
    );

    test(
      'should return UserDataRetrievalFailure when fetching user data failed',
      () async {
        // arrange
        _arrangeConnection(isConnected: true);
        _arraneLoadUserWebDataSourceFail();
        // act
        final _username = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_username, Left(UserDataRetrievalFailure()));
      },
    );
  });

  group('saving user data, ', () {
    void _arraneSaveUserWebDataSourceSuccess() {
      when(_mockUserWebDataSource.saveUsername(_testUsername))
          .thenAnswer((_) async => _testUsername);
    }

    void _arraneSaveUserWebDataSourceFail() {
      when(_mockUserWebDataSource.saveUsername(_testUsername))
          .thenThrow(UnimplementedError());
    }

    test(
      'should return check if there is connection',
      () async {
        // act
        await _userDataRetriverImpl.saveUserData(_testUser);
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
        final _res = await _userDataRetriverImpl.saveUserData(_testUser);
        // assert
        expect(_res, Left(NoConnetionFailure()));
      },
    );

    test(
      'should save username on web when  csucces',
      () async {
        // arrange
        _arrangeConnection();
        _arraneSaveUserWebDataSourceSuccess();
        // act
        await _userDataRetriverImpl.saveUserData(_testUser);
        // assert
        verify(_mockUserWebDataSource.saveUsername(_testUsername)).called(1);
      },
    );

    test(
      'should  return ServerFailure if saving user fails',
      () async {
        // arrange
        _arrangeConnection();
        _arraneSaveUserWebDataSourceFail();

        // act
        final _res = await _userDataRetriverImpl.saveUserData(_testUser);
        // assert
        expect(_res, Left(ServerFailure()));
      },
    );
  });
}
