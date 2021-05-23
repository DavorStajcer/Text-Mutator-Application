import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String username;

  AppUser(this.username);

  @override
  List<Object?> get props => [username];
}
