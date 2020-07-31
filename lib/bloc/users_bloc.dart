import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/models/registered_users_model.dart';
import 'package:bloc_test/models/fetched_users_model.dart';
import 'package:bloc_test/services/api_services.dart';
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
          final result = await ApiServices().fetchUsers();
          print('result====???>>>$result');
          yield UserFetched(users: Users.fromJson(result));
        }
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    } else if (event is RegisterUser) {
      try {
        final result = await ApiServices().registerUser(
            {"email": event.userName, "password": event.password});
        // yield UserLoading();
        yield UserRegisterd(createdUser: RegisterdUser.fromJson(result));
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    }
  }
}
