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
          floatingActionButton: FloatingActionButton(onPressed: () {
            UsersBloc()..add(CreateUser());
          }),
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
  UsersBloc _userBloc;
  @override
  void initState() {
    _userBloc = BlocProvider.of<UsersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
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
        return ListView.builder(
          itemCount: state.users.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(state.users.data[index].firstName),
            );
          },
        );
      }
      if (state is CreateSuccess) {
        print('object');
        return Text('REG');
      }
    });
  }
}
