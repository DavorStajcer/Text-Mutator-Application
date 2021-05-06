import 'package:equatable/equatable.dart';

abstract class Word extends Equatable {
  final String? word;
  final int? index;
  bool isSelected;
  Word(
    this.word,
    this.index,
    this.isSelected,
  );
}
