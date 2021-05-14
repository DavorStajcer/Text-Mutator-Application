import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:text_mutator/core/constants/theme.dart';
import 'package:text_mutator/core/local_storage_manager/local_storage_manager.dart';

part 'theme_changing_state.dart';

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final _lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: LIGHT_PRIMARY_COLOR,
  accentColor: LIGHT_HIGHLIGHTED_COLOR,
  brightness: Brightness.light,
  backgroundColor: LIGHT_PRIMARY_COLOR,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      letterSpacing: 2,
      color: LIGHT_TEXT_COLOR,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      wordSpacing: 2,
      color: LIGHT_TEXT_COLOR.withAlpha(150),
    ),
    headline1: TextStyle(
      fontSize: 50,
      letterSpacing: -3,
      fontWeight: FontWeight.w900,
      color: LIGHT_HIGHLIGHTED_COLOR,
    ),
    headline2: TextStyle(
      fontSize: 30,
      letterSpacing: 3,
      fontWeight: FontWeight.w700,
      color: LIGHT_TEXT_COLOR,
    ),
    headline3: TextStyle(
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.bold,
      color: LIGHT_TEXT_COLOR,
    ),
  ),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);

class ThemeChangingCubit extends Cubit<ThemeChangingState> {
  final LocalStorageManager _localStorageManager;
  ThemeChangingCubit(this._localStorageManager)
      : super(ThemeChangingInitial(_lightTheme));

  void setInitialThemeBasedOnUserSettings() async {
    final bool _isLight = _localStorageManager.getUserThemeOptions();
    this.emit(ThemeChanged(_isLight ? _lightTheme : _darkTheme));
  }
}
