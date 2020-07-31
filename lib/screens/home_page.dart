import 'package:bloc_test/bloc/users_bloc.dart';
import 'package:bloc_test/screens/components/custom_alert_dialog.dart';
import 'package:bloc_test/screens/components/registerd_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _userNameController;
  TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _onPressed() {
    Navigator.pop(context);
    context
        .bloc<UsersBloc>()
        .add(RegisterUser(_userNameController.text, _passwordController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      print(state);
      if (state is UsersInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UserFailure) {
        return Center(
          child: Text('Failed to fetch posts'),
        );
      }
      if (state is UserFetched) {
        if (state.users.total == 0) {
          return Center(
            child: Text('NO POSTS AVAILABLE'),
          );
        }
        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: state.users.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(state.users.data[index].firstName),
                  );
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        passwordController: _passwordController,
                        userNameController: _userNameController,
                        title: 'Enter Details',
                        onPressed: _onPressed,
                      );
                    });
              },
              child: Container(
                height: 30,
                width: 60,
                child: Center(child: Text('Register USER')),
              ),
            )
          ],
        );
      }
      if (state is UserRegisterd) {
        return Center(
          child: RegisteredUser(
            email: state.createdUser.email,
            password: state.createdUser.password,
            id: state.createdUser.id,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
