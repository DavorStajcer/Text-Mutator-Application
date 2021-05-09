part of 'text_bloc.dart';

@immutable
abstract class TextState extends Equatable {
  const TextState();
}

class TextInitial extends TextState {
  @override
  List<Object?> get props => [];
}

class TextLoading extends TextState {
  @override
  List<Object?> get props => [];
}

class TextLoaded extends TextState {
  final Text text;
  const TextLoaded(this.text);
  @override
  List<Object?> get props => [text];
}

class TextError extends TextState {
  final String message;

  TextError(this.message);
  @override
  List<Object?> get props => [message];
}
