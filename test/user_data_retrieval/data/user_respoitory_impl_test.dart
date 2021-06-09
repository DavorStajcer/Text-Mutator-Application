//@dart=2.9
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/authentication/signed_user_provider.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/repositories/user_repository_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_retriever.dart';

class MockUserDataRetriver extends Mock implements UserDataRetriver {}

class MockSignedUserProvider extends Mock implements SignedUserProvider {}

void main() {
  UserRepositoryImpl _userRepositoryImpl;
  MockUserDataRetriver _mockUserDataRetriver;
  MockFirebaseAuth _mockFirebaseAuth;
  MockSignedUserProvider _mockSignedUserProvider;

  final String _testUsername = 'awsome_user';

  final AppUser _testUser = AppUser(_testUsername);

  _setupNoUsername() {
    _mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser(), signedIn: true);
    _mockUserDataRetriver = MockUserDataRetriver();
    _mockSignedUserProvider = MockSignedUserProvider();
    _userRepositoryImpl = UserRepositoryImpl(
      _mockSignedUserProvider,
      _mockUserDataRetriver,
    );
  }

  group('loading user data', () {
    void _setupUserDataRetrievalSucces() {
      when(_mockUserDataRetriver.getUserData())
          .thenAnswer((_) async => Right(_testUser));
    }

    void _setupUserDataRetrievalFailure(Failure fialure) {
      when(_mockUserDataRetriver.getUserData())
          .thenAnswer((_) async => Left(fialure));
    }

    test(
      'should call UserRetriver if there is no username avaliable',
      () async {
        // arrange
        _setupNoUsername();
        _setupUserDataRetrievalSucces();
        // act
        await _userRepositoryImpl.getUserData();
        // assert
        verify(_mockUserDataRetriver.getUserData()).called(1);
        verifyNoMoreInteractions(_mockUserDataRetriver);
      },
    );

    test(
      'should return correct AppUser when data retrieval is successful',
      () async {
        // arrange
        _setupNoUsername();
        _setupUserDataRetrievalSucces();
        // act
        final _res = await _userRepositoryImpl.getUserData();
        // assert
        expect(_res, Right(_testUser));
      },
    );

    test(
      'should return propper failure when it goes wrong - NoConnectionFailure',
      () async {
        // arrange
        _setupNoUsername();
        _setupUserDataRetrievalFailure(NoConnetionFailure());
        // act
        final _res = await _userRepositoryImpl.getUserData();
        // assert
        expect(_res, Left(NoConnetionFailure()));
      },
    );

    test(
      'should return propper failure when it goes wrong - ServerFailure',
      () async {
        // arrange
        _setupNoUsername();
        _setupUserDataRetrievalFailure(ServerFailure());
        // act
        final _res = await _userRepositoryImpl.getUserData();
        // assert
        expect(_res, Left(ServerFailure()));
      },
    );
  });

  group('saving user data, ', () {
    void _setupUserDataSavingSucces() {
      _mockFirebaseAuth = MockFirebaseAuth(
          mockUser: MockUser(displayName: _testUsername), signedIn: true);
      _mockUserDataRetriver = MockUserDataRetriver();
      _mockSignedUserProvider = MockSignedUserProvider();
      _userRepositoryImpl = UserRepositoryImpl(
        _mockSignedUserProvider,
        _mockUserDataRetriver,
      );
      when(_mockUserDataRetriver.saveUserData(_testUser))
          .thenAnswer((_) async => Right(null));
    }

    void _setupUserDataSavingFailure(Failure fialure) {
      _mockFirebaseAuth = MockFirebaseAuth(
          mockUser: MockUser(displayName: _testUsername), signedIn: true);
      _mockUserDataRetriver = MockUserDataRetriver();
      _mockSignedUserProvider = MockSignedUserProvider();
      _userRepositoryImpl = UserRepositoryImpl(
        _mockSignedUserProvider,
        _mockUserDataRetriver,
      );
      when(_mockUserDataRetriver.saveUserData(_testUser))
          .thenAnswer((_) async => Left(fialure));
    }

    test(
      'should call .saveUserData',
      () async {
        // arrange
        _setupUserDataSavingSucces();
        // act
        await _userRepositoryImpl.saveUserData(_testUser);
        // assert
        verify(_mockUserDataRetriver.saveUserData(_testUser)).called(1);
        verifyNoMoreInteractions(_mockUserDataRetriver);
      },
    );

    test(
      'should return Right(void) if saving successful',
      () async {
        // arrange
        _setupUserDataSavingSucces();
        // act
        final _res = await _userRepositoryImpl.saveUserData(_testUser);
        // assert
        expect(_res, Right(null));
      },
    );

    test(
      'should return Left(failure) if saving returns failure',
      () async {
        // arrange
        _setupUserDataSavingFailure(NoConnetionFailure());
        // act
        final _res = await _userRepositoryImpl.saveUserData(_testUser);
        // assert
        expect(_res, Left(NoConnetionFailure()));
      },
    );
  });
}
