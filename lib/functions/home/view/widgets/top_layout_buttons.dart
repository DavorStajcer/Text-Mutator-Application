import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';
import '../../../../core/constants/pages.dart';
import '../../../../core/widgets/app_button.dart';

class TopLayoutButtons extends StatelessWidget {
  const TopLayoutButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    final AutoSizeGroup _textGroup = AutoSizeGroup();
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

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
                      autoSizeGroup: _textGroup,
                      onTap: () {
                        BlocProvider.of<ResultsGraphBloc>(context)
                            .add(LoadResults());
                        Navigator.of(context)
                            .pushNamed(ROUTE_USER_RESULTS_PREVIEW_PAGE);
                      }),
                ],
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocConsumer<AuthBloc, AuthBlocState>(
                listener: (ctx, authState) {
                  if (authState is AuthBlocInitial)
                    Navigator.of(context)
                        .pushReplacementNamed(ROUTE_AUTHENTICATION_PAGE);
                },
                builder: (ctx, authState) {
                  if (authState is AuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return IconButton(
                    onPressed: () => _authBloc.add(SignOut()),
                    icon: Icon(Icons.login_outlined),
                    color: Theme.of(ctx).accentColor,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
