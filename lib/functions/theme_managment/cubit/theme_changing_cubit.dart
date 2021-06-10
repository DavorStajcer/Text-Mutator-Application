import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/theme.dart';
import '../../../core/local_storage_manager/local_storage_manager.dart';

part 'theme_changing_state.dart';

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: DARK_HIGHLIGHTED_COLOR,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(DARK_HIGHLIGHTED_COLOR),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      letterSpacing: 2,
      color: DARK_TEXT_COLOR,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      wordSpacing: 2,
      color: DARK_TEXT_COLOR.withAlpha(150),
    ),
    headline1: TextStyle(
      fontSize: 40,
      letterSpacing: -1.5,
      fontWeight: FontWeight.w900,
      color: DARK_HIGHLIGHTED_COLOR,
    ),
    headline2: TextStyle(
      fontSize: 30,
      letterSpacing: 3,
      fontWeight: FontWeight.w700,
      color: DARK_TEXT_COLOR,
    ),
    headline3: TextStyle(
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.bold,
      color: DARK_TEXT_COLOR,
    ),
  ),
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
      fontSize: 40,
      letterSpacing: -1.5,
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
      : super(ThemeChangingInitial(_lightTheme, true)) {
    this.setInitialThemeBasedOnUserSettings();
  }

  void setInitialThemeBasedOnUserSettings() async {
    final bool _isLight = _localStorageManager.getUserThemeOptions();
    this.emit(ThemeChanged(_isLight ? _lightTheme : _darkTheme, _isLight));
  }

  void changeTheme(bool isLight) async {
    await _localStorageManager.saveUserThemeOptions(isLight);
    this.emit(ThemeChanged(isLight ? _lightTheme : _darkTheme, isLight));
  }
}
