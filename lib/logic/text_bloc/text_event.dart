part of 'text_bloc.dart';

@immutable
abstract class TextEvent {
  const TextEvent();
}

class ParseToText extends TextEvent {
  final String text;
  const ParseToText(this.text);
}
