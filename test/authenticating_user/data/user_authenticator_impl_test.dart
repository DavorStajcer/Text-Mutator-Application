//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/authenticating_user/data/user_authenticator_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  MockFirebaseAuth _mockFirebaseAuth;
  UserAuthenticatorImpl userAuthenticatorImpl;

  setUp(() async {
    _mockFirebaseAuth = MockFirebaseAuth();
    userAuthenticatorImpl = UserAuthenticatorImpl(_mockFirebaseAuth);
  });

  final String _testEmail = 'email@gmail.com';
  final String _testPass = 'testpass1234';
  final UserCredential _testCredential = MockUserCredential();

  test(
    'should try to authenticate with username and password',
    () async {
      // arrange
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
    'should return UserAuthenticationFailure when FirebaseAuthException happens',
    () async {
      // arrange
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
    'should return ServerFailure when exception other then FirebaseAuthException happens',
    () async {
      // arrange
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
