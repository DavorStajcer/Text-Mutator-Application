import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../progress_animation_cubit/progress_animation_cubit.dart';
import 'progress_animated_bar.dart';
import 'progress_animated_circle.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  final Size deviceSize;
  const ProgressIndicatorWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  @override
  _ProgressIndicatorWidgetState createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      upperBound: 1.0,
      lowerBound: 0.0,
      value: 0.0,
      duration: Duration(milliseconds: 900),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final double _circleWidth = widget.deviceSize.width * 0.1;

    return BlocListener<ProgressAnimationCubit, ProgressAnimationState>(
      listener: (context, state) {
        _animationController.animateTo(state.value / 3);
      },
      child: SizedBox(
        height: widget.deviceSize.height * 0.035,
        width: widget.deviceSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Center(
                child: Divider(
                  endIndent: _circleWidth / 2,
                  indent: _circleWidth / 2,
                  color: _theme.accentColor.withAlpha(140),
                  thickness: 1.5,
                ),
              ),
              ProgressAnimatedBar(
                circleWidth: _circleWidth,
                theme: _theme,
                animationController: _animationController,
                maxWidth: widget.deviceSize.width - _circleWidth * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: _theme.accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _theme.textTheme.bodyText1!.color!)),
                    width: _circleWidth,
                  ),
                  ProgressAnimatedCircle(
                    theme: _theme,
                    circleWidth: _circleWidth,
                    animationController: _animationController,
                    beginAnimation: 0.23,
                    endAnimation: 0.33,
                  ),
                  ProgressAnimatedCircle(
                    theme: _theme,
                    circleWidth: _circleWidth,
                    animationController: _animationController,
                    beginAnimation: 0.56,
                    endAnimation: 0.66,
                  ),
                  ProgressAnimatedCircle(
                    theme: _theme,
                    circleWidth: _circleWidth,
                    animationController: _animationController,
                    beginAnimation: 0.90,
                    endAnimation: 1.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
