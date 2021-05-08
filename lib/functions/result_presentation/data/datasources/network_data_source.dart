import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';

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
    final QuerySnapshot _querySnapshot = await instance
        .collection('users')
        .doc('$_currentUserId')
        .collection('results')
        .get();

    return _querySnapshot.docs
        .map((e) => e.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<void> saveResult(ResultModel resultModel) async {
    final String _currentUserId = _firebaseAuth.currentUser!.uid;
    final Map<String, dynamic> _newResult = resultModel.toJson();
    await instance
        .collection('users')
        .doc('$_currentUserId')
        .collection('results')
        .add(_newResult);
  }
}
