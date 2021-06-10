import 'dart:developer';

import 'package:text_mutator/core/authentication/signed_user_provider.dart';
import '../../domain/models/app_user.dart';
import '../../../../core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/user_data_retriever.dart';

class UserRepositoryImpl extends UserDataRepository {
  // final FirebaseAuth _firebaseAuth;
  // final GoogleSignIn _googleSignIn;
  final UserDataRetriver _userDataRetriver;
  final SignedUserProvider _signedUserProvider;

  UserRepositoryImpl(this._signedUserProvider, this._userDataRetriver);

  @override
  Future<Either<Failure, AppUser>> getUserData() async {
    String? _userDisplayName = _signedUserProvider.getCurrentUserUsername();

    if (_userDisplayName != null) {
      return Right(AppUser(_userDisplayName));
    }
    final _userDataRetrieved = await _userDataRetriver.getUserData();
    return _userDataRetrieved.fold((Failure failure) => Left(failure),
        (AppUser appUser) => Right(appUser));
  }

  @override
  Future<Either<Failure, void>> saveUserData(AppUser appUser) async {
    return await _userDataRetriver.saveUserData(appUser);
  }
}
