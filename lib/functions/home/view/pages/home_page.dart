import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_mutator/core/widgets/scaffold_web.dart';
import 'package:text_mutator/functions/home/view/widgets/web/home_page_description_web.dart';
import 'package:text_mutator/functions/home/view/widgets/web/home_page_top_web.dart';
import '../widgets/top_layout_theme_button.dart';
import '../widgets/bottom_layout.dart';
import '../widgets/top_layout_buttons.dart';
import '../widgets/top_layout_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return kIsWeb ? _buildWeb(_theme, context) : _buildMobile(_theme);
  }

  Widget _buildWeb(ThemeData theme, BuildContext context) {
    return ScaffoldWeb(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 2400,
          width: double.infinity,
          child: Column(
            children: [
              HomePageTopWeb(),
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: HomePageDescriptionWeb(),
              ),
            ],
          ),
        ),
      ),
    );
    // });
  }

  Widget _buildMobile(ThemeData _theme) {
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
