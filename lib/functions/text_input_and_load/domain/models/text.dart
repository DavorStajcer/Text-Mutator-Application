import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Text extends Equatable {
  final String? text;
  final String? name;
  final String? id;
  const Text({this.text = '', required this.name, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, text];
}
