import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:text_mutator/functions/theme_managment/cubit/theme_changing_cubit.dart';
import '../widgets/top_layout_theme_button.dart';
import '../widgets/bottom_layout.dart';
import '../widgets/top_layout_buttons.dart';
import '../widgets/top_layout_text.dart';

const String TEXT_LOAD =
    "Choose a text you wish to practice on! You can get a text from our database with different text difficulties, or find and copy text you wish to practice on and start!";
const String TEXT_MUATATION =
    "Your text will be \"mutated\" by adding words in the text that do not belong there. Your goal is to cross out the imposter words! Try to put conjuctions (a, and, or...) into your text to make it more challenging!";
const String TEXT_RESULT =
    "You can preview your result and see what words you missed.  Track your results by loging in and see your imporovments!";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return kIsWeb ? _buildWeb(_theme, context) : _buildMobile(_theme);
  }

  Widget _buildWeb(ThemeData theme, BuildContext context) {
    // return LayoutBuilder(builder: (ctx, contraints) {
    //   final double _scgHeight = 200;
    //   final double _svgWidth = 200;

    return SingleChildScrollView(
      child: SizedBox(
        height: 2400,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
                builder: (context, state) {
                  return SvgPicture.asset(
                    'assets/svg/web/headline.svg',
                    fit: BoxFit.fill,
                    color: state.theme.accentColor,
                    // width: _svgWidth,
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      TEXT_LOAD,
                      style: theme.textTheme.bodyText1,
                      maxLines: null,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SvgPicture.asset(
                      'assets/svg/web/choose_text.svg',
                      // height: _svgWidth,
                      // width: _svgWidth,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SvgPicture.asset(
                      'assets/svg/web/find_mutated_words.svg',
                      // height: _svgWidth,
                      // width: _svgWidth,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      TEXT_MUATATION,
                      maxLines: null,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      TEXT_RESULT,
                      maxLines: null,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SvgPicture.asset(
                      'assets/svg/web/track_results.svg',
                      // height: _svgWidth,
                      // width: _svgWidth,
                    ),
                  )
                ],
              ),
            ),
          ],
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
