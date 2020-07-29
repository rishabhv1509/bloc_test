part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class FetchUsers extends UsersEvent {
  @override
  List<Object> get props => [];
}

class CreateUser extends UsersEvent {
  final String userName;
  final String password;

  CreateUser(this.userName, this.password);
  @override
  List<Object> get props => [];
}
