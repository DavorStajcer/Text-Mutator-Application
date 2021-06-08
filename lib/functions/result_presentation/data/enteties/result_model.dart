import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/result.dart';

class ResultModel extends Result {
  ResultModel(
    int mutatedWords,
    int wrongWords,
    int numberOfMarkedWords,
    double difficulty,
    String id, {
    DateTime? date,
  }) : super(
          id: id,
          numberOfMutatedWords: mutatedWords,
          numberOfMarkedWords: numberOfMarkedWords,
          numberOfWrongWords: wrongWords,
          difficulty: difficulty,
          dateOfResult: date ?? DateTime.now(),
        );

  factory ResultModel.fromJson(Map<String, dynamic> map) {
    return ResultModel(
      map['mutatedWords'],
      map['wrongWords'],
      map['numberOfMarkedWords'],
      map['difficulty'],
      map['id'],
      date: map['date'] == null ? null : (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mutatedWords': this.numberOfMutatedWords,
      'wrongWords': this.numberOfWrongWords,
      'numberOfMarkedWords': this.numberOfMarkedWords,
      'difficulty': this.difficulty,
      'date': this.date
    };
  }
}
