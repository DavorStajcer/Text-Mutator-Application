import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../enteties/result_model.dart';

abstract class NetworkResultDataSource {
  Future<List<Map<String, dynamic>>> fetchResults();
  Future<void> saveResult(ResultModel resultModel);
}

class NetworkResultDataSourceImpl extends NetworkResultDataSource {
  final FirebaseFirestore instance;
  final FirebaseAuth _firebaseAuth;

  NetworkResultDataSourceImpl(this.instance, this._firebaseAuth);

  @override
  Future<List<Map<String, dynamic>>> fetchResults() async {
    final String _currentUserId = _firebaseAuth.currentUser!.uid;
    final DocumentSnapshot _documentSnapshot = await instance
        .collection('users')
        .doc('$_currentUserId')
        .collection('results')
        .doc('results')
        .get();

    //     .map((e) =>
    //         (e.data() as Map<String, dynamic>)..putIfAbsent('id', () => e.id))
    //     .toList();

    return (_documentSnapshot.data() as Map<String, dynamic>)['list'];
  }

  @override
  Future<void> saveResult(ResultModel resultModel) async {
    final String _currentUserId = _firebaseAuth.currentUser!.uid;
    final Map<String, dynamic> _newResult = resultModel.toJson();

    final _collection = instance
        .collection('users')
        .doc('$_currentUserId')
        .collection('results');

    try {
      await _collection.doc("results").update({
        'list': FieldValue.arrayUnion([_newResult])
      });
    } catch (err) {
      log(err.toString());
      await _collection.doc('results').set({
        'list': [_newResult]
      });
    }
  }
}
