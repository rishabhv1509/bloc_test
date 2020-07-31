import 'package:bloc_test/bloc/users_bloc.dart';
import 'package:bloc_test/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BLOC Test'),
        ),
        body: BlocProvider(
            create: (context) => UsersBloc()..add(FetchUsers()),
            child: MyHomePage()),
      ),
    );
  }
}
