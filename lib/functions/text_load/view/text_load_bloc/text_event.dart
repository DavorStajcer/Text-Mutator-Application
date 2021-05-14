part of 'text_bloc.dart';

@immutable
abstract class TextEvent extends Equatable {
  const TextEvent();
}

class LoadText extends TextEvent {
  final TextDifficulty textDifficulty;

  LoadText({required this.textDifficulty}) : super();

  @override
  List<Object?> get props => [textDifficulty];
}

class TextChanged extends TextEvent {
  final String text;

  TextChanged(this.text);

  @override
  List<Object?> get props => [];
}

class SaveText extends TextEvent {
  final Text text;

  SaveText(this.text);

  @override
  List<Object?> get props => [text];
}
