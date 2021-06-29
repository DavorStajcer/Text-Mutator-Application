import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/theme_managment/cubit/theme_changing_cubit.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';

class HomePageTopWeb extends StatelessWidget {
  const HomePageTopWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final bool _isDesktop = constraints.maxWidth >= 1000;
        final bool _isTablet =
            constraints.maxWidth >= 750 && constraints.maxWidth < 1000;

        final bool _isMobile = constraints.maxWidth < 750;

        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: _isDesktop
                      ? 700
                      : _isTablet
                          ? 600
                          : 400,
                  width: MediaQuery.of(ctx).size.width,
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
              ],
            ),
            Column(
              mainAxisAlignment: _isMobile
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: _isMobile ? 80 : 200,
                ),
                AutoSizeText(
                  'Mutext',
                  style: _isDesktop
                      ? _theme.textTheme.headline1!.copyWith(
                          fontSize: 100,
                        )
                      : _theme.textTheme.headline1,
                ),
                AutoSizeText(
                  'Start reading better today.',
                  style: _theme.textTheme.headline2,
                ),
                SizedBox(
                  height: 120,
                ),
                BlocBuilder<UserDataBloc, UserDataState>(
                    builder: (context, userDataState) {
                  if (userDataState is UserDataLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Hello, ${userDataState.user.username}! ',
                          style: _theme.textTheme.headline2,
                        ),
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Hello, practice anonimus, or',
                        style: _theme.textTheme.headline2,
                      ),
                      AppButton(
                        text: 'join',
                        textStyle: _theme.textTheme.headline2!
                            .copyWith(color: _theme.accentColor),
                        onTap: () => Navigator.of(context)
                            .pushNamed(ROUTE_AUTHENTICATION_PAGE),
                      ),
                      AutoSizeText(
                        'and track results!',
                        style: _theme.textTheme.headline2,
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      text: 'Practice reading.',
                      textStyle: _theme.textTheme.headline2!
                          .copyWith(color: _theme.accentColor),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    AppButton(
                      text: 'How does it work?',
                      textStyle: _theme.textTheme.headline2!.copyWith(
                        color: _theme.accentColor,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
