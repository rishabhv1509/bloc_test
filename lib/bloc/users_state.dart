part of 'users_bloc.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UserFailure extends UsersState {}

class UserLoading extends UsersState {}

class UserFetched extends UsersState {
  final Users users;
  UserFetched({this.users});
  UserFetched copyWith() {
    return UserFetched(
      users: users ?? this.users,
    );
  }
}

class UserRegisterd extends UsersState {
  final RegisterdUser createdUser;
  UserRegisterd({this.createdUser});
  UserRegisterd copyWith() {
    return UserRegisterd(
      createdUser: createdUser ?? this.createdUser,
    );
  }
}
