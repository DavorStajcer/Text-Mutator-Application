import 'package:text_mutator/functions/result_presentation/domain/models/result.dart';

class ResultModel extends Result {
  ResultModel(
    int mutatedWords,
    int wrongWords,
    int numberOfMarkedWords,
    double difficulty,
    String id,
  ) : super(
          id: id,
          mutatedWords: mutatedWords,
          numberOfMarkedWords: numberOfMarkedWords,
          wrongWords: wrongWords,
          difficulty: difficulty,
        );

  factory ResultModel.fromJson(Map<String, dynamic> map) {
    return ResultModel(
      map['mutatedWords'],
      map['wrongWords'],
      map['numberOfMarkedWords'],
      map['difficulty'],
      map['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mutatedWords': this.mutatedWords,
      'wrongWords': this.wrongWords,
      'numberOfMarkedWords': this.numberOfMarkedWords,
      'difficulty': this.difficulty,
      'id': this.id,
    };
  }
}
