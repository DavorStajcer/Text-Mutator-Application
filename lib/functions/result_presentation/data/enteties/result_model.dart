import '../../domain/models/result.dart';

class ResultModel extends Result {
  ResultModel(
    int mutatedWords,
    int wrongWords,
    int numberOfMarkedWords,
    double difficulty,
    String id,
  ) : super(
          id: id,
          numberOfMutatedWords: mutatedWords,
          numberOfMarkedWords: numberOfMarkedWords,
          numberOfWrongWords: wrongWords,
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
      'mutatedWords': this.numberOfMutatedWords,
      'wrongWords': this.numberOfWrongWords,
      'numberOfMarkedWords': this.numberOfMarkedWords,
      'difficulty': this.difficulty,
    };
  }
}
