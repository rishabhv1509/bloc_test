import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/models/create_users.dart';
import 'package:bloc_test/models/users.dart';
import 'package:bloc_test/services/apiServices.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial());

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchUsers) {
      try {
        if (currentState is UsersInitial) {
          final result = await ApiServices().getUsers();
          print('result====???>>>$result');
          yield UserSuccess(users: Users.fromJson(result));
        }
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    } else if (event is CreateUser) {
      try {
        final result = await ApiServices()
            .ceateUser({"email": "email", "password": "password"});
        yield UserLoading();
        yield CreateSuccess(createdUser: CreateUsers.fromJson(result));
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    }
  }
}
