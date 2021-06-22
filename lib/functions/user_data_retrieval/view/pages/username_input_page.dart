import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../authenticating_user/view/widgets/auth_input_form/auth_input_field.dart';
import '../../domain/models/app_user.dart';
import '../user_data_bloc/user_data_bloc.dart';
import '../user_data_validator_cubit/user_data_validator_cubit.dart';

class UsernameInputPage extends StatelessWidget {
  const UsernameInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    final UserDataBloc _userDataBloc = BlocProvider.of<UserDataBloc>(context);
    final UserDataValidatorCubit _userDataValidatorCubit =
        BlocProvider.of<UserDataValidatorCubit>(context);

    log(_userDataBloc.state.toString());

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: SingleChildScrollView(
        child: BlocConsumer<UserDataBloc, UserDataState>(
            listener: (ctx, userData) {
          if (userData is UserDataLoaded) {
            Navigator.of(context).pushReplacementNamed(
              ROUTE_WELCOME_PAGE,
            );
          }
        }, builder: (ctx, userData) {
          if (userData is! UserDataError) return Center();
          return SizedBox(
            height: _deviceSize.height,
            width: _deviceSize.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Welcome to Mutext!',
                          textAlign: TextAlign.left,
                          style: _theme.textTheme.headline1,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'What should we call you?',
                          textAlign: TextAlign.left,
                          style: _theme.textTheme.headline2,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    BlocBuilder<UserDataValidatorCubit, UserDataValidatorState>(
                      builder: (_, userDataValidatorState) {
                        return Flexible(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: AuthInputField(
                                  errorMessage:
                                      userDataValidatorState.errorMessage,
                                  theme: _theme,
                                  onChanged: (String username) =>
                                      _userDataValidatorCubit
                                          .validateData(AppUser(username)),
                                  highlitedBorder: _getNFocusedBorder(_theme),
                                  normalBorder: _getNormalBorder(_theme),
                                  title: 'username',
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              userDataValidatorState is! UserDataValid
                                  ? Container()
                                  : AppButton(
                                      text: 'Submit',
                                      onTap: () => _userDataBloc.add(
                                        SaveUserData(
                                          AppUser(
                                              userDataValidatorState.username),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

OutlineInputBorder _getNormalBorder(ThemeData theme) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
    borderSide: BorderSide(width: 1, color: theme.textTheme.bodyText1!.color!),
  );
}

OutlineInputBorder _getNFocusedBorder(ThemeData theme) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
    borderSide: BorderSide(width: 2, color: theme.accentColor),
  );
}
