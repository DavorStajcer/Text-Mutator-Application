import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/functions/text_load/view/text_load_bloc/text_bloc.dart';

class TextLoadPage extends StatefulWidget {
  const TextLoadPage({Key? key}) : super(key: key);

  @override
  _TextLoadPageState createState() => _TextLoadPageState();
}

class _TextLoadPageState extends State<TextLoadPage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: _theme.textTheme.bodyText1!.color!,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(20),
              // color: Colors.green,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: BlocBuilder<TextBloc, TextState>(
                builder: (context, state) {
                  if (state is TextLoaded)
                    _textEditingController.text = state.text.text;

                  return TextField(
                    style: _theme.textTheme.bodyText1,
                    onChanged: (String text) {},
                    decoration: InputDecoration(
                      errorBorder: null,
                      enabledBorder: null,
                      focusedBorder: null,
                      disabledBorder: null,
                      focusedErrorBorder: null,
                      hintText:
                          'Load a text you wish to mutate\n or write your own',
                    ),
                    maxLines: null,
                  );
                },
              ),
            ),
          ),
        ),

        AppButton(
          text: 'Load',
          widthSizeFactor: 3,
          onTap: () {},
        ),
        // AppButton(
        //   text: 'Save',
        //   widthSizeFactor: 3,
        //   onTap: () {},
        // ),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
