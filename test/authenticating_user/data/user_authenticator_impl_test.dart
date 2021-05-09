//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/authenticating_user/data/user_authenticator_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredential extends Mock implements UserCredential {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  MockFirebaseAuth _mockFirebaseAuth;
  UserAuthenticatorImpl userAuthenticatorImpl;
  MockConnectionChecker _mockConnectionChecker;

  setUp(() async {
    _mockFirebaseAuth = MockFirebaseAuth();
    _mockConnectionChecker = MockConnectionChecker();
    userAuthenticatorImpl = UserAuthenticatorImpl(
      _mockFirebaseAuth,
      _mockConnectionChecker,
    );
  });

  void _setupConnection(bool isConnected) {
    when(_mockConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) async => isConnected);
  }

  final String _testEmail = 'email@gmail.com';
  final String _testPass = 'testpass1234';
  final UserCredential _testCredential = MockUserCredential();

  test(
    'should try to authenticate with username and password on sign in',
    () async {
      // arrange
      _setupConnection(true);
      when(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .thenAnswer((_) async => _testCredential);

      await userAuthenticatorImpl.authenticateUserWithEmailAndPassword(
          _testEmail, _testPass);

      verify(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .called(1);
      verifyNoMoreInteractions(_mockFirebaseAuth);
    },
  );

  test(
    'should return UserAuthenticationFailure when FirebaseAuthException happens on sign in',
    () async {
      // arrange
      _setupConnection(true);
      when(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));
      //act
      final res = await userAuthenticatorImpl
          .authenticateUserWithEmailAndPassword(_testEmail, _testPass);
      // assert
      expect(res, Left(UserAuthenticationFailure(ERROR_AUTH_USER_NOT_FOUND)));
      verify(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .called(1);
      verifyNoMoreInteractions(_mockFirebaseAuth);
    },
  );

  test(
    'should return NoConnectionFailure when not connected to internet while signing in',
    () async {
      // arrange
      _setupConnection(false);

      //act
      final res = await userAuthenticatorImpl
          .authenticateUserWithEmailAndPassword(_testEmail, _testPass);
      // assert
      expect(res, Left(NoConnetionFailure()));
      verifyNever(_mockFirebaseAuth.signInWithEmailAndPassword(
          email: _testEmail, password: _testPass));
    },
  );

  test(
    'should return UserAuthenticationFailure when FirebaseAuthException happens on sign up',
    () async {
      // arrange
      _setupConnection(true);
      when(_mockFirebaseAuth.createUserWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .thenThrow(FirebaseAuthException(code: 'weak-password'));
      //act
      final res = await userAuthenticatorImpl.signUp(_testEmail, _testPass);
      // assert
      expect(res, Left(UserAuthenticationFailure(ERROR_AUTH_WEAK_PASSWORD)));
      verify(_mockFirebaseAuth.createUserWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .called(1);
      verifyNoMoreInteractions(_mockFirebaseAuth);
    },
  );

  test(
    'should return NoConnectionFailure when not connected to internet whiel signing up',
    () async {
      // arrange
      _setupConnection(false);

      //act
      final res = await userAuthenticatorImpl.signUp(_testEmail, _testPass);
      // assert
      expect(res, Left(NoConnetionFailure()));
      verifyNever(_mockFirebaseAuth.createUserWithEmailAndPassword(
          email: _testEmail, password: _testPass));
    },
  );

  test(
    'should return ServerFailure when exception other then FirebaseAuthException happens while signing up',
    () async {
      // arrange
      _setupConnection(true);
      when(_mockFirebaseAuth.createUserWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .thenThrow(UnimplementedError());
      //act
      final res = await userAuthenticatorImpl.signUp(_testEmail, _testPass);
      // assert
      expect(res, Left(ServerFailure()));
      verify(_mockFirebaseAuth.createUserWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .called(1);
      verifyNoMoreInteractions(_mockFirebaseAuth);
    },
  );

  test(
    'should return ServerFailure when exception other then FirebaseAuthException happens on sign in',
    () async {
      // arrange
      _setupConnection(true);
      when(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .thenThrow(UnimplementedError());
      //act
      final res = await userAuthenticatorImpl
          .authenticateUserWithEmailAndPassword(_testEmail, _testPass);
      // assert
      expect(res, Left(ServerFailure()));
      verify(_mockFirebaseAuth.signInWithEmailAndPassword(
              email: _testEmail, password: _testPass))
          .called(1);
      verifyNoMoreInteractions(_mockFirebaseAuth);
    },
  );
}
