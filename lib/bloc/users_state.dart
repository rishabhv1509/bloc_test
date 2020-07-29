part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class UserFailure extends UsersState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UsersState {
  @override
  List<Object> get props => [];
}

class UserSuccess extends UsersState {
  final Users users;
  UserSuccess({this.users});
  UserSuccess copyWith({
    Users posts,
  }) {
    return UserSuccess(
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [users];
}

class CreateSuccess extends UsersState {
  @override
  List<Object> get props => [];
}
