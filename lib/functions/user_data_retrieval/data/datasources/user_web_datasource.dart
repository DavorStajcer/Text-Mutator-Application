import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_data_source.dart';

class UserWebDataSource extends UserDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  UserWebDataSource(
    this._firebaseFirestore,
    this._firebaseAuth,
  );

  @override
  Future<String?> getUsername() async {
    final DocumentSnapshot _doc = await _firebaseFirestore
        .doc('users/${_firebaseAuth.currentUser!.uid}')
        .get();
    if (!_doc.exists) return null;
    return (_doc.data() as Map<String, dynamic>)['username'];
  }

  @override
  Future<void> saveUsername(String username) async {
    try {
      await _firebaseFirestore
          .doc('users/${_firebaseAuth.currentUser!.uid}')
          .update({'username': username});
    } catch (err) {
      await _firebaseFirestore
          .doc('users/${_firebaseAuth.currentUser!.uid}')
          .set({'username': username});
    }
  }
}
