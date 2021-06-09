part of 'theme_changing_cubit.dart';

abstract class ThemeChangingState extends Equatable {
  final ThemeData theme;
  final bool isLight;
  const ThemeChangingState(this.theme, this.isLight);

  @override
  List<Object> get props => [theme];
}

class ThemeChangingInitial extends ThemeChangingState {
  ThemeChangingInitial(ThemeData theme, bool isLight) : super(theme, isLight);
}

class ThemeChanged extends ThemeChangingState {
  ThemeChanged(ThemeData theme, bool isLight) : super(theme, isLight);
}
