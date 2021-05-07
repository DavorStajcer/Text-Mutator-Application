part of 'textvalidator_bloc.dart';

abstract class TextValidatorEvent extends Equatable {
  final String text;
  const TextValidatorEvent(this.text);

  @override
  List<Object> get props => [text];
}

class TextChanged extends TextValidatorEvent {
  TextChanged(String text) : super(text);
}
