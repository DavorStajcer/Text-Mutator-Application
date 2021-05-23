//@dart=2.9

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/error/exceptions/exceptions.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_local_datasource.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_web_datasource.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_retriver_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';

class MockUserWebDataSource extends Mock implements UserWebDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

void main() {
  MockUserWebDataSource _mockUserWebDataSource;
  MockUserLocalDataSource _mockUserLocalDataSource;
  MockConnectionChecker _mockConnectionChecker;
  UserDataRetriverImpl _userDataRetriverImpl;

  setUp(() {
    _mockUserWebDataSource = MockUserWebDataSource();
    _mockConnectionChecker = MockConnectionChecker();
    _mockUserLocalDataSource = MockUserLocalDataSource();
    _userDataRetriverImpl = UserDataRetriverImpl(_mockUserWebDataSource,
        _mockConnectionChecker, _mockUserLocalDataSource);
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

    void _arraneLoadUserLocalDataSourceSuccess() {
      when(_mockUserLocalDataSource.getUsername())
          .thenAnswer((_) async => _testUsername);
    }

    void _arraneLoadUserLocalDataSourceFail() {
      when(_mockUserLocalDataSource.getUsername())
          .thenAnswer((_) async => null);
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
      'should call .getUsername on user local datasource and no calls for web when success',
      () async {
        // arrange

        _arrangeConnection(isConnected: true);
        _arraneLoadUserLocalDataSourceSuccess();
        // act
        await _userDataRetriverImpl.getUserData();
        // assert
        verify(_mockUserLocalDataSource.getUsername()).called(1);
        verifyZeroInteractions(_mockUserWebDataSource);
        verifyNoMoreInteractions(_mockUserWebDataSource);
      },
    );

    test(
      'should return correct username when local is succes',
      () async {
        // arrange

        _arrangeConnection(isConnected: true);
        _arraneLoadUserLocalDataSourceSuccess();

        // act
        final _res = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_res, Right(_testUser));
      },
    );

    test(
      'should call .getUsername on user web datasource when local failed',
      () async {
        // arrange

        _arrangeConnection(isConnected: true);
        _arraneLoadUserLocalDataSourceFail();
        _arraneLoadUserWebDataSourceSuccess();
        // act
        await _userDataRetriverImpl.getUserData();
        // assert
        verify(_mockUserLocalDataSource.getUsername()).called(1);
        verify(_mockUserWebDataSource.getUsername()).called(1);

        verifyNoMoreInteractions(_mockUserWebDataSource);
        verifyNoMoreInteractions(_mockUserLocalDataSource);
      },
    );

    test(
      'should return correct username when local failed and web succeeded',
      () async {
        // arrange

        _arrangeConnection(isConnected: true);
        _arraneLoadUserLocalDataSourceFail();
        _arraneLoadUserWebDataSourceSuccess();
        // act
        final _res = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_res, Right(_testUser));
      },
    );

    test(
      'should return UserDataRetrievalFailure when local and web fail to retrieve username',
      () async {
        // arrange

        _arrangeConnection(isConnected: true);
        _arraneLoadUserLocalDataSourceFail();
        _arraneLoadUserWebDataSourceFail();
        // act
        final _res = await _userDataRetriverImpl.getUserData();
        // assert
        expect(_res, Left(UserDataRetrievalFailure()));
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

    void _arraneSaveUserLocalDataSourceSuccess() {
      when(_mockUserLocalDataSource.saveUsername(_testUsername))
          .thenAnswer((_) async => _testUsername);
    }

    void _arraneSaveUserLocalDataSourceFail() {
      when(_mockUserLocalDataSource.saveUsername(_testUsername))
          .thenThrow(LocalStorageException());
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
      'should save username on web and locally when all succes',
      () async {
        // arrange
        _arrangeConnection();
        _arraneSaveUserLocalDataSourceSuccess();
        _arraneSaveUserWebDataSourceSuccess();
        // act
        await _userDataRetriverImpl.saveUserData(_testUser);
        // assert
        verify(_mockUserWebDataSource.saveUsername(_testUsername)).called(1);
        verify(_mockUserLocalDataSource.saveUsername(_testUsername)).called(1);
      },
    );

    test(
      'should ONLY call saveUsername on web if web fails, and return ServerFailure',
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

    test(
      'should return UserDataRetreivalFailure when web savcing passses but local thros LocalStorageException',
      () async {
        // arrange
        _arrangeConnection();
        _arraneSaveUserWebDataSourceSuccess();
        _arraneSaveUserLocalDataSourceFail();
        // act
        final _res = await _userDataRetriverImpl.saveUserData(_testUser);
        // assert
        expect(_res, Left(UserDataRetrievalFailure()));
      },
    );
  });
}
