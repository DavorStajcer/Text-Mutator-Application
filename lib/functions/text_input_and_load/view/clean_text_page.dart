import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'package:text_mutator/functions/text_input_and_load/view/text_bloc/text_bloc.dart';

class CleanTextPage extends StatefulWidget {
  const CleanTextPage({Key? key}) : super(key: key);

  @override
  _CleanTextPageState createState() => _CleanTextPageState();
}

class _CleanTextPageState extends State<CleanTextPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  showCursor: true,
                  maxLines: null,
                ),
              ),
            ),
            BlocBuilder<TextBloc, TextState>(
              builder: (context, state) {
                if (state is TextLoading) {
                  return CircularProgressIndicator();
                } else {
                  return TextButton(
                    onPressed: () {
                      BlocProvider.of<MutateBloc>(context, listen: false)
                          .add(MutateText(_textEditingController.text, 4));
                      Navigator.of(context).pushNamed('/mutatedScreen');
                    },
                    child: Text("Mutate text"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
