import 'package:text_mutator/core/constants/error_messages.dart';

abstract class TextValidator {
  String? isValid(String text);
}

class TextValidatorImpl extends TextValidator {
  @override
  String? isValid(String text) {
    final List<String> _words = text.split(' ');

    if (_words.length < 100) return TEXT_VALIDATION_SHORT;
    if (!_isTextLegit(_words, text.length)) return TEXT_IS_NOT_DIVERSE_ENOUGH;
    return null;
  }

//TODO: IMPLEMENT THIS FUNCTIONALITY SO THAT IT ISNT CALLED ON EVERY TEXT TYPE MBY?
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

    // print('passed length check');
    //text needs to have at least 1/4 * terxt length different words
    if (_sameWords.keys.length < ((1 / 4) * words.length)) return false;
    // print('passed different words check');
    //one word can maximim appear 1/3 of the text lenght times
    if (_sameWords.values.any(
        (numberOfApperances) => numberOfApperances > ((1 / 3) * words.length)))
      return false;
    // print('passed one word max check');
    //one letter can be max 33% of the text
    // print(_sameLetters.toString());
    if (_sameLetters.values.any((element) => element >= (0.33 * textLength)))
      return false;
    // print('passed one letter max check');
    return true;
  }
}
