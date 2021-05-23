import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/models/app_user.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/repositories/user_repository.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_retriever.dart';

class UserRepositoryImpl extends UserDataRepository {
  final FirebaseAuth _firebaseAuth;
  final UserDataRetriver _userDataRetriver;

  UserRepositoryImpl(this._firebaseAuth, this._userDataRetriver);

  @override
  Future<Either<Failure, AppUser>> getUserData() async {
    String? _userDisplayName = _firebaseAuth.currentUser!.displayName;
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
