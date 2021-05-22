import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _firebaseAuth;

  NetworkTextDataSourceImpl(this._firebaseFirestore, this._firebaseAuth);

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
    final QuerySnapshot _res = await _firebaseFirestore
        .collection('users/${_firebaseAuth.currentUser!.uid}')
        .get();
    if (_res.docs.isEmpty) return [];
    return _res.docs
        .map((e) => (e.data() as Map<String, dynamic>)['id'])
        .toList() as List<String>;
  }

  @override
  Future<void> saveSolvedText(String id) async {
    log(_firebaseAuth.currentUser!.uid);
    await _firebaseFirestore
        .collection('users/${_firebaseAuth.currentUser!.uid}/solvedTexts')
        .add({'id': id});
  }
}
