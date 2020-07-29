import 'dart:async';

import 'package:bloc/bloc.dart';
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
    }
    if (event is CreateUser) {
      try {
        if (currentState is UsersInitial) {
          print('IN CEAE');
          final result = await ApiServices()
              .ceateUser({"email": "test", "password": "password"});
          // if(result.)
          yield UserLoading();
          print('IN CEAE 2');
          print(result);
          yield CreateSuccess();
          print('IN CEAE 3');
        }
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    }
  }
}
