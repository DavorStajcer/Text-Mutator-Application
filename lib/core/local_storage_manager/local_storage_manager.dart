import 'package:shared_preferences/shared_preferences.dart';

const String SHARED_PREF_THEME_KEY = 'isLight';
const String SHARED_PREF_LAST_SOLVED_DATE_KEY = 'lastSolvedData';

abstract class LocalStorageManager {
  bool getUserThemeOptions();
  Future<bool> saveUserThemeOptions(bool isLight);
  Future<bool> saveLastSolvedDate();
  Future<bool> getIsLastSolvedDateMoreThenOneDay();
}

class LocalStorageManagerImpl extends LocalStorageManager {
  final SharedPreferences sharedPreferences;

  LocalStorageManagerImpl(this.sharedPreferences);

  bool getUserThemeOptions() {
    final _desiredTheme = sharedPreferences.get(SHARED_PREF_THEME_KEY);
    if (_desiredTheme == null) return false;
    return _desiredTheme as bool;
  }

  Future<bool> saveUserThemeOptions(bool isLight) async {
    return await sharedPreferences.setBool(SHARED_PREF_THEME_KEY, isLight);
  }

  Future<bool> saveLastSolvedDate() async {
    return await sharedPreferences.setString(
        SHARED_PREF_LAST_SOLVED_DATE_KEY, DateTime.now().toIso8601String());
  }

  Future<bool> getIsLastSolvedDateMoreThenOneDay() async {
    final _lastSolvedDateString =
        sharedPreferences.getString(SHARED_PREF_LAST_SOLVED_DATE_KEY);
    if (_lastSolvedDateString == null) return false;

    final DateTime _lastSolvedDate = DateTime.parse(_lastSolvedDateString);
    final DateTime _todayDate = DateTime.now();

    if (_lastSolvedDate.month != _todayDate.month) return false;

    return (_todayDate.day - _lastSolvedDate.day < 2);
  }
}
