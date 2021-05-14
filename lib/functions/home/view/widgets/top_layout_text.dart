import 'package:flutter/material.dart';

class TopLayoutText extends StatelessWidget {
  const TopLayoutText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: _deviceSize.height / 10,
          horizontal: _deviceSize.width / 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Ivan.',
            style: _theme.textTheme.headline1,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Practice reading and learn the better.',
            style: _theme.textTheme.headline2,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
