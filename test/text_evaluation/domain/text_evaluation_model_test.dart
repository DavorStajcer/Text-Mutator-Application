//@dart= 2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/functions/text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';

void main() {
  TextEvaluationModel textEvaluationModel;

  final Text _testText =
      Text.createDifficulty(text: 'a a a a a a a a a a', id: 'test');
  test(
    'should calculate result difficulty  to be 35',
    () async {
      // arrange
      textEvaluationModel = TextEvaluationModel(_testText, 1, true, false);
      // act
      expect(textEvaluationModel.resultDifficulty, 40.0);
      // assert
    },
  );

  test(
    'should calculate result difficulty  to be 32.5',
    () async {
      // arrange
      textEvaluationModel = TextEvaluationModel(_testText, 1, true, true);
      // act
      expect(textEvaluationModel.resultDifficulty, 50.0);
      // assert
    },
  );
}
