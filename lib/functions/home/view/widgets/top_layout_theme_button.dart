import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../theme_managment/cubit/theme_changing_cubit.dart';

class TopLayoutThemeButton extends StatelessWidget {
  const TopLayoutThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    final ThemeChangingCubit _themeChangingCubit =
        BlocProvider.of<ThemeChangingCubit>(context);

    return _buildThemeChangeButton(_deviceSize, _themeChangingCubit);
  }

  MouseRegion _buildThemeChangeButton(
      Size _deviceSize, ThemeChangingCubit _themeChangingCubit) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
          builder: (context, state) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 100,
              ),
              child: FlutterSwitch(
                width: _deviceSize.width / 3.4,
                height: kIsWeb ? 40 : _deviceSize.height * 0.05,
                value: state.isLight,
                showOnOff: true,
                inactiveIcon: Icon(
                  Icons.dark_mode,
                  color: Colors.yellow,
                ),
                activeText: 'Light',
                activeIcon: Icon(Icons.light_mode),
                inactiveToggleColor: Colors.black,
                inactiveText: 'Dark',
                onToggle: (val) {
                  _themeChangingCubit.changeTheme(val);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
