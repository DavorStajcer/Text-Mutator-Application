import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme_managment/cubit/theme_changing_cubit.dart';

class BottomLayout extends StatelessWidget {
  const BottomLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
      builder: (context, state) {
        return SvgPicture.asset(
          'assets/svg/lady.svg',
          height: _deviceSize.height / 1.5,
          color: state.isLight ? Colors.black : Colors.blue,
        );
      },
    );
  }
}
