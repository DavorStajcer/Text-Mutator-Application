import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';

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
                textAlign: TextAlign.left,
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          AutoSizeText(
            'Practice reading and learn the better.',
            style: _theme.textTheme.headline2,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
