import 'package:flutter/cupertino.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';

class Text {
  final String text;
  final String name;
  final String id;
  const Text({this.text = '', @required this.name, @required this.id});
}
