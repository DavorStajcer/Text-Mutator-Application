import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    Future.delayed(
      Duration(milliseconds: 1100),
      () => Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE),
    );

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            'Mutext',
            style: _theme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
