import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/theme.dart';

import '../../../user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';

class TopLayoutText extends StatelessWidget {
  const TopLayoutText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: _deviceSize.height / 7, horizontal: _deviceSize.width / 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserDataBloc, UserDataState>(
            builder: (context, state) {
              late final String _username;
              if (state is UserDataLoaded)
                _username = state.user.username;
              else
                _username = 'user';
              return AutoSizeText(
                'Hello $_username.',
                style: _theme.textTheme.headline1,
                maxLines: 1,
                textAlign: TextAlign.left,
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: _deviceSize.height / 4,
                maxWidth: _deviceSize.width * 0.82),
            child: AutoSizeText.rich(
              TextSpan(
                text: 'Practice reading and learn ',
                style: _theme.textTheme.headline2,
                children: [
                  TextSpan(
                    text: 'the',
                    style: _theme.textTheme.headline2!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2.5,
                      color: FADED_TEXT,
                    ),
                  ),
                  TextSpan(
                    text: ' better.',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
