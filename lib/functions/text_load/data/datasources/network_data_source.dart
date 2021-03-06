import 'dart:developer';

import '../../../../core/authentication/signed_user_provider.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../enteties/text_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NetworkTextDataSource {
  Future<Map<String, dynamic>> fetchText(
      String textDifficulty, List<String> solvedTexts);
  Future<List<String>> fetchSolvedTextIds();
  Future<void> saveSolvedText(String id);
  Future<String> saveText(TextModel textModel, String textDifficulty);
}

class NetworkTextDataSourceImpl extends NetworkTextDataSource {
  final FirebaseFirestore _firebaseFirestore;
  // final GoogleSignIn _googleSignIn;
  final SignedUserProvider _signedUserProvider;

  // final FirebaseAuth _firebaseAuth;
  NetworkTextDataSourceImpl(this._signedUserProvider, this._firebaseFirestore);

  @override
  Future<Map<String, dynamic>> fetchText(
      String textDifficulty, List<String> solvedTexts) async {
    final QuerySnapshot<Map<String, dynamic>> _snapshot =
        await _firebaseFirestore
            .collection('text/kgffDVkJl6VHcPCyOZd1/$textDifficulty')
            .get();

    QueryDocumentSnapshot<Map<String, dynamic>> _doc =
        _findFirstNotReadText(_snapshot, solvedTexts);

    return _doc.data()..putIfAbsent('id', () => _doc.id);
  }

  QueryDocumentSnapshot<Map<String, dynamic>> _findFirstNotReadText(
      QuerySnapshot<Map<String, dynamic>> _snapshot, List<String> solvedTexts) {
    final _doc = _snapshot.docs.firstWhere(
        (QueryDocumentSnapshot element) => !solvedTexts.contains(element.id),
        orElse: () => throw AllTextsSolvedException());
    return _doc;
  }

  @override
  Future<String> saveText(TextModel textModel, String textDifficulty) async {
    final DocumentReference _documentReference = await _firebaseFirestore
        .collection('text/kgffDVkJl6VHcPCyOZd1/$textDifficulty')
        .add(textModel.toJson());
    return _documentReference.id;
  }

  @override
  Future<List<String>> fetchSolvedTextIds() async {
    final DocumentSnapshot _res = await _firebaseFirestore
        .doc('users/${_signedUserProvider.getCurrentUserId()}')
        .get();
    if (!_res.exists) return [];
    if (_res.data() == null) return [];

    final _data = (_res.data() as Map<String, dynamic>);

    return _data['solvedTexts'] == null
        ? []
        : (_data['solvedTexts'] as List<dynamic>).cast<String>();
  }

  @override
  Future<void> saveSolvedText(String id) async {
    log('user id:' + _signedUserProvider.getCurrentUserId());
    try {
      await _firebaseFirestore
          .doc('users/${_signedUserProvider.getCurrentUserId()}')
          .update({
        'solvedTexts': FieldValue.arrayUnion([id])
      });
    } catch (err) {
      await _firebaseFirestore
          .doc('users/${_signedUserProvider.getCurrentUserId()}')
          .set({
        'solvedTexts': [id]
      });
    }
  }
}
