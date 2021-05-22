import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataSource {
  Future<String> getUsername();
}

class UserDataSourceImpl extends UserDataSource {
  final FirebaseAuth _firebaseAuth;

  UserDataSourceImpl(this._firebaseAuth);

  @override
  Future<String> getUsername() {
    throw UnimplementedError();
  }
}
