//@dart = 2.9

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/authenticating_user/domain/contracts/user_authenticator.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';

class MockUserAuthenticator extends Mock implements UserAuthenticator {}

void main() {
  MockUserAuthenticator _mockUserAuthenticator;

  setUp(() {
    _mockUserAuthenticator = MockUserAuthenticator();
  });

  final String _testEmail = 'test@gmail.com';
  final String _testPass = 'test_pass';

  void _setupMockLogin(bool outcome) {
    when(_mockUserAuthenticator.authenticateUserWithEmailAndPassword(
            _testEmail, _testPass))
        .thenAnswer((_) async => outcome
            ? Right(null)
            : Left(UserAuthenticationFailure(ERROR_AUTH_INVALID_EMAIL)));
  }

  void _setupMockSignup(bool outcome) {
    when(_mockUserAuthenticator.signUp(_testEmail, _testPass)).thenAnswer(
        (_) async => outcome
            ? Right(null)
            : Left(UserAuthenticationFailure(ERROR_AUTH_WEAK_PASSWORD)));
  }

  blocTest(
    'should emit AuthBlocInitial',
    build: () => AuthBloc(_mockUserAuthenticator),
    expect: () => [],
  );
  group('sign in', () {
    blocTest(
      'should emit AuthLoading and then AUthSuccesfull on succes',
      build: () {
        _setupMockLogin(true);
        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(LogIn(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthSuccesfull(true)],
    );

    blocTest(
      'should emit AuthLoading and then AuthFailed with ERROR_AUTH_INVALID_EMAIL message on firebase failure while',
      build: () {
        _setupMockLogin(false);
        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(LogIn(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthFailed(ERROR_AUTH_INVALID_EMAIL)],
    );

    blocTest(
      'should emit AuthLoading and then AuthFailed with ERROR_AUTH_NO_CONNECTION message when not connected',
      build: () {
        when(_mockUserAuthenticator.authenticateUserWithEmailAndPassword(
                _testEmail, _testPass))
            .thenAnswer((_) async => Left(NoConnetionFailure()));
        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(LogIn(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthFailed(ERROR_NO_CONNECTION)],
      verify: (ab) => _mockUserAuthenticator
          .authenticateUserWithEmailAndPassword(_testEmail, _testPass),
    );
  });

  group('sign up', () {
    blocTest(
      'should emit AuthLoading and then AuthSuccess',
      build: () {
        _setupMockSignup(true);
        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(SignUp(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthSuccesfull(true)],
      verify: (ab) => _mockUserAuthenticator.signUp(_testEmail, _testPass),
    );
    blocTest(
      'should emit AuthLoading and then AuthFailed with ERROR_AUTH_WEAK_PASSWORD message on firebase failure',
      build: () {
        _setupMockSignup(false);
        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(SignUp(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthFailed(ERROR_AUTH_WEAK_PASSWORD)],
      verify: (ab) => _mockUserAuthenticator.signUp(_testEmail, _testPass),
    );

    blocTest(
      'should emit AuthLoading and then AuthFailed with ERROR_AUTH_NO_CONNECTION message when not connected',
      build: () {
        when(_mockUserAuthenticator.signUp(_testEmail, _testPass))
            .thenAnswer((_) async => Left(NoConnetionFailure()));

        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(SignUp(_testEmail, _testPass)),
      expect: () => [AuthLoading(), AuthFailed(ERROR_NO_CONNECTION)],
      verify: (ab) => _mockUserAuthenticator.signUp(_testEmail, _testPass),
    );
  });

  group('sing out', () {
    blocTest(
      'should emit AuthLoading and then AuthInitial when succesfull sign out',
      build: () {
        when(_mockUserAuthenticator.signOut())
            .thenAnswer((_) async => Right(null));

        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(SignOut()),
      expect: () => [AuthLoading(), AuthBlocInitial()],
      verify: (ab) => _mockUserAuthenticator.signOut(),
    );

    blocTest(
      'should emit AuthLoading and then AuthFailed with ERROR_AUTH_NO_CONNECTION message when not connected',
      build: () {
        when(_mockUserAuthenticator.signOut())
            .thenAnswer((_) async => Left(NoConnetionFailure()));

        return AuthBloc(_mockUserAuthenticator);
      },
      act: (ab) => ab.add(SignOut()),
      expect: () => [AuthLoading(), AuthFailed(ERROR_NO_CONNECTION)],
      verify: (ab) => _mockUserAuthenticator.signOut(),
    );
  });
}
