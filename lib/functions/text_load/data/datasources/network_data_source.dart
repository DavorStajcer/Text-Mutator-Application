import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/error/exceptions/exceptions.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NetworkTextDataSource {
  Future<Map<String, dynamic>> fetchText(
      String textDifficulty, List<String> solvedTexts);
  Future<List<String>> fetchSolvedTextIds();
  Future<void> saveSolvedText(String id);
  Future<void> saveText(TextModel textModel, String textDifficulty);
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
  Future<void> saveText(TextModel textModel, String textDifficulty) async {
    await _firebaseFirestore
        .collection('text/kgffDVkJl6VHcPCyOZd1/$textDifficulty')
        .add(textModel.toJson());
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
    await _firebaseFirestore
        .collection('users/${_firebaseAuth.currentUser!.uid}')
        .add({'id': id});
  }
}
