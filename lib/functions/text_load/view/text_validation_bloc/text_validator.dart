import 'dart:developer';

import '../../../../core/constants/error_messages.dart';

abstract class TextValidator {
  String? isValid(String text);
}

class TextValidatorImpl extends TextValidator {
  @override
  String? isValid(String text) {
    log(text + ', ' + (text.length * 0.1).toString());
    final List<String> _words = text.split(' ');
    if (_words.length < (text.length * 0.1)) return TEXT_VALIDATION_SHORT;
    if (!_isTextLegit(_words, text.length)) return TEXT_IS_NOT_DIVERSE_ENOUGH;
    return null;
  }

  bool _isTextLegit(List<String> words, int textLength) {
    int _lengthSum = 0;
    Map<String, int> _sameWords = {};
    Map<String, int> _sameLetters = {};

    for (int i = 0; i < words.length; i++) {
      _lengthSum += words[i].length;
      _sameWords.update(words[i], (value) => value + 1, ifAbsent: () => 1);
      for (int j = 0; j < words[i].length; j++) {
        _sameLetters.update(words[i][j], (value) => value + 1,
            ifAbsent: () => 1);
      }
    }
    //average word lenght less then 3
    if ((_lengthSum / words.length) <= 3) return false;
    if (_sameWords.keys.length < ((1 / 4) * words.length)) return false;
    if (_sameWords.values.any((numberOfApperances) =>
        numberOfApperances > ((1 / 3) * words.length).toInt())) return false;
    if (_sameLetters.values.any((element) => element >= (0.33 * textLength)))
      return false;
    return true;
  }
}
