import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:text_mutator/core/constants/texts.dart';

class HomePageDescriptionWeb extends StatelessWidget {
  const HomePageDescriptionWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  TEXT_LOAD,
                  style: _theme.textTheme.bodyText1,
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
                  style: _theme.textTheme.bodyText1,
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
                  style: _theme.textTheme.bodyText1,
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
    );
  }
}
