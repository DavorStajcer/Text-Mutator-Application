abstract class TextValidator {
  String? isValid(String text);
}

const String TEXT_VALIDATION_SHORT = '';

class TextValidatorImpl extends TextValidator {
  @override
  String? isValid(String text) {
    final List<String> _words = text.split(' ');

    if (_words.length < 100) return TEXT_VALIDATION_SHORT;
  }

  bool _isAllShort(List<String> words) {
    int _lengthSum = 0;
    Map<String, int> _sameWords =


  }
}
