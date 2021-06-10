import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/dialog.dart';
import '../user_data_bloc/user_data_bloc.dart';

class WelcomePage extends StatelessWidget {
  final bool isDataAllreadyLoaded;
  const WelcomePage({Key? key, this.isDataAllreadyLoaded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final UserDataBloc _userDataBloc = BlocProvider.of<UserDataBloc>(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    if (!isDataAllreadyLoaded)
      _userDataBloc.add(LoadUserData());
    else
      Future.delayed(Duration(milliseconds: 800),
          () => Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE));

    return BlocListener<UserDataBloc, UserDataState>(
      listener: (context, userDataState) {
        if (userDataState is UserDataLoaded)
          Future.delayed(
            Duration(milliseconds: 1100),
            () => Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE),
          );
        else if (userDataState is UserDataError)
          showNotificationDialog(context, userDataState.message, _theme).then(
              (value) => Navigator.of(context)
                  .pushReplacementNamed(ROUTE_AUTHENTICATION_PAGE));
      },
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/virus_background_new.svg',
                  height: _deviceSize.height / 4,
                  width: _deviceSize.width * 0.7,
                ),
                SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                  'Mutext',
                  style: _theme.textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
