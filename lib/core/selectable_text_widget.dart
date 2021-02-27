import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_mutator/data/models/words/word.dart';

class SelectableTextWidget extends StatefulWidget {
  final Word word;
  bool _tapped = false;
  SelectableTextWidget(this.word);

  bool get isTapped => _tapped;

  void clear() => _tapped = false;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectableTextWidgetState();
  }
}

class _SelectableTextWidgetState extends State<SelectableTextWidget> {
  TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();

    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        HapticFeedback.vibrate();
        setState(() {
          widget._tapped = !widget._tapped;
        });
      };
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final TextStyle _defaultStyle = Theme.of(context).textTheme.bodyText1;

    return RichText(
      softWrap: true,
      text: TextSpan(
        text: widget.word.word + ' ',
        style: widget._tapped
            ? _defaultStyle.copyWith(decoration: TextDecoration.lineThrough)
            : _defaultStyle,
        recognizer: _recognizer,
      ),
    );
  }
}
