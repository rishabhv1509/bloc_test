part of 'users_bloc.dart';

abstract class UsersEvent {}

class FetchUsers extends UsersEvent {}

class RegisterUser extends UsersEvent {
  final String userName;
  final String password;
  RegisterUser(this.userName, this.password);
}
