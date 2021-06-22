import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/pages.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1100), () {
      if (this.mounted)
        Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

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
