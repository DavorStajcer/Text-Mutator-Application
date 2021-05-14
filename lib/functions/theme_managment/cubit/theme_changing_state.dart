part of 'theme_changing_cubit.dart';

abstract class ThemeChangingState extends Equatable {
  final ThemeData theme;
  const ThemeChangingState(this.theme);

  @override
  List<Object> get props => [theme];
}

class ThemeChangingInitial extends ThemeChangingState {
  ThemeChangingInitial(ThemeData theme) : super(theme);
}

class ThemeChanged extends ThemeChangingState {
  ThemeChanged(ThemeData theme) : super(theme);
}
