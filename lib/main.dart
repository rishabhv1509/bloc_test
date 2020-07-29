import 'package:bloc_test/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc()..add(FetchUsers()),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('BLOC Test'),
          ),
          body: MyHomePage(),
        ),
      ),
    );
  }
}

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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      print(state);
      if (state is UsersInitial) {
        print('IN INIT');
        return Center(child: CircularProgressIndicator());
      }
      if (state is UserFailure) {
        print('IN FAIL');

        return Center(
          child: Text('Failed to fetch posts'),
        );
      }
      if (state is UserSuccess) {
        print('IN Success');
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
                      return AlertDialog(
                        title: Text(
                            'NO GOOD PUTTING FIELDS, DEFAULT USERNAME AND PASSWORD GOES ALWAYS '),
                        content: Container(
                          height: 200,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Username'),
                                  Expanded(
                                    child: TextField(
                                      controller: _userNameController,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Password'),
                                  Expanded(
                                    child: TextField(
                                      controller: _passwordController,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.bloc<UsersBloc>().add(CreateUser(
                                    _userNameController.text,
                                    _passwordController.text));
                              },
                              child: Text(
                                'ok',
                              ))
                        ],
                      );
                    });
              },
              child: Container(
                height: 30,
                width: 60,
                child: Center(child: Text('ADD USER')),
              ),
            )
          ],
        );
      }
      if (state is CreateSuccess) {
        return Center(
            child: Column(
          children: <Widget>[
            Text('ID CHANGES AFTER EVERY CALL'),
            Text('EMAIL: ${state.createdUser.email}'),
            Text('PASSWORD: ${state.createdUser.password}'),
            Text('ID: ${state.createdUser.id}'),
          ],
        ));
      } else {
        return Container();
      }
    });
  }
}
