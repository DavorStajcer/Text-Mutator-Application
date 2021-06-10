import 'package:flutter/material.dart';
import '../widgets/top_layout_theme_button.dart';
import '../widgets/bottom_layout.dart';
import '../widgets/top_layout_buttons.dart';
import '../widgets/top_layout_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: -30,
            child: BottomLayout(),
          ),
          TopLayoutText(),
          TopLayoutButtons(),
          Positioned(
            top: 40,
            right: 20,
            child: TopLayoutThemeButton(),
          ),
        ],
      ),
    );
  }
}
