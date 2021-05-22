import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';

class TopLayoutButtons extends StatelessWidget {
  const TopLayoutButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    final AutoSizeGroup _textGroup = AutoSizeGroup();

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: _deviceSize.height / 10,
          horizontal: _deviceSize.width / 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _deviceSize.height / 3.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  AppButton(
                    text: 'Practice',
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(ROUTE_MUTATION_FLOW_PAGE),
                    autoSizeGroup: _textGroup,
                  ),
                  AppButton(
                    text: 'Results',
                    onTap: () {},
                    autoSizeGroup: _textGroup,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
