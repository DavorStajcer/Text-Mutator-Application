//@dart=2.9

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/repositories/user_repository.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';

class MockUserDataRepository extends Mock implements UserDataRepository {}

void main() {
  MockUserDataRepository _mockUserDataRepository;
  UserDataBloc _userDataBloc;

  setUp(() {
    _mockUserDataRepository = MockUserDataRepository();
  });

  final String _testUsername = 'awsome_user';
  final AppUser _testUser = AppUser(_testUsername);

  void _setUpLoadDataSuccess() {
    when(_mockUserDataRepository.getUserData())
        .thenAnswer((_) async => Right(_testUser));
  }

  void _setUpLoadDataFailure(Failure failure) {
    when(_mockUserDataRepository.getUserData())
        .thenAnswer((_) async => Left(failure));
  }

  void _setUpSavingDataSuccess() {
    when(_mockUserDataRepository.saveUserData(_testUser))
        .thenAnswer((_) async => Right(_testUser));
  }

  void _setUpSavingDataFailure(Failure failure) {
    when(_mockUserDataRepository.saveUserData(_testUser))
        .thenAnswer((_) async => Left(failure));
  }

  group('loading user data, ', () {
    blocTest(
      'emit call .getUserData when LoadUserData event',
      build: () {
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(LoadUserData()),
      verify: (_) => verify(_mockUserDataRepository.getUserData()).called(1),
    );
    blocTest(
      'emit [UserDataLoading, UserDataLoaded] on successful data retrival',
      build: () {
        _setUpLoadDataSuccess();
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(LoadUserData()),
      expect: () => [UserDataLoading(), UserDataLoaded(_testUser)],
    );

    blocTest(
      'emit [UserDataLoading, UserDataError] on with ERROR_NO_CONNECTION message whern NoConnectionFailure',
      build: () {
        _setUpLoadDataFailure(NoConnetionFailure());
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(LoadUserData()),
      expect: () => [UserDataLoading(), UserDataError(ERROR_NO_CONNECTION)],
    );

    blocTest(
      'emit [UserDataLoading, UserDataError] on with ERROR_RETRIEVING_USER_DATA message whern UserDataRetrievalFailure',
      build: () {
        _setUpLoadDataFailure(UserDataRetrievalFailure());
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(LoadUserData()),
      expect: () =>
          [UserDataLoading(), UserDataError(ERROR_RETRIEVING_USER_DATA)],
    );
  });

  group('saving user data, ', () {
    blocTest(
      'emit call .saveUserData when SaveUserData event',
      build: () {
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(SaveUserData(_testUser)),
      verify: (_) =>
          verify(_mockUserDataRepository.saveUserData(_testUser)).called(1),
    );

    blocTest(
      'emit [UserDataLoading, UserDataLoaded] on successful data saving',
      build: () {
        _setUpSavingDataSuccess();
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(SaveUserData(_testUser)),
      expect: () => [UserDataLoading(), UserDataLoaded(_testUser)],
    );

    blocTest(
      'emit [UserDataLoading, UserDataError] on with ERROR_NO_CONNECTION message whern NoConnectionFailure',
      build: () {
        _setUpSavingDataFailure(NoConnetionFailure());
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(SaveUserData(_testUser)),
      expect: () => [UserDataLoading(), UserDataError(ERROR_NO_CONNECTION)],
    );

    blocTest(
      'emit [UserDataLoading, UserDataError] on with ERRROR_SERVER_FAILURE message when ServerFailure',
      build: () {
        _setUpSavingDataFailure(ServerFailure());
        return UserDataBloc(_mockUserDataRepository);
      },
      act: (bloc) => bloc.add(SaveUserData(_testUser)),
      expect: () => [UserDataLoading(), UserDataError(ERROR_SERVER_FAILURE)],
    );
  });
}
