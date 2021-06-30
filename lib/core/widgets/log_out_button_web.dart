import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';

class LogOutButtonWeb extends StatelessWidget {
  const LogOutButtonWeb({
    Key? key,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        super(key: key);

  final AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, userDataState) {
        if (userDataState is UserDataLoaded) {
          print("user data state, for theme: " + userDataState.toString());
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  onPressed: () => _authBloc.add(SignOut()),
                  icon: Icon(Icons.login_outlined),
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          );
        }
        return Container();
      },
      buildWhen: (a, b) => a != b,
    );
  }
}
