import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_action_state.dart';

class AuthenticationActionCubit extends Cubit<AuthenticationActionState> {
  AuthenticationActionCubit() : super(AuthenticationActionLogin());

  void changeAuthenitcationAction() => emit(state is AuthenticationActionLogin
      ? AuthenticationActionSignup()
      : AuthenticationActionLogin());

  void setInitial() => emit(AuthenticationActionLogin());
}
