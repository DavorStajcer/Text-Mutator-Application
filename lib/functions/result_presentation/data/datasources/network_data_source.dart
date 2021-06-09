import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_mutator/core/authentication/signed_user_provider.dart';
import '../enteties/result_model.dart';

abstract class NetworkResultDataSource {
  Future<List<Map<String, dynamic>>> fetchResults();
  Future<void> saveResult(ResultModel resultModel);
}

class NetworkResultDataSourceImpl extends NetworkResultDataSource {
  final FirebaseFirestore instance;
  final SignedUserProvider _signedUserProvider;

  NetworkResultDataSourceImpl(this.instance, this._signedUserProvider);

  @override
  Future<List<Map<String, dynamic>>> fetchResults() async {
    final String _currentUserId = _signedUserProvider.getCurrentUserId();
    final DocumentSnapshot _documentSnapshot =
        await instance.collection('users').doc('$_currentUserId').get();

    final _responseRes =
        (_documentSnapshot.data() as Map<String, dynamic>)['results'];

    if (_responseRes == null) return [];

    final _list = (_responseRes as List<dynamic>).cast<Map<String, dynamic>>();

    return _list;
  }

  @override
  Future<void> saveResult(ResultModel resultModel) async {
    final String _currentUserId = _signedUserProvider.getCurrentUserId();
    final Map<String, dynamic> _newResult = resultModel.toJson();

    final _doc = instance.collection('users').doc('$_currentUserId');

    try {
      await _doc.update({
        'results': FieldValue.arrayUnion([_newResult])
      });
    } catch (err) {
      log(err.toString());
      await _doc.set({
        'results': [_newResult]
      });
    }
  }
}
