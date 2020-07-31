import 'package:flutter/material.dart';

class RegisteredUser extends StatelessWidget {
  final String email;
  final String password;
  final String id;

  const RegisteredUser({Key key, this.email, this.password, this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('EMAIL: $email'),
        Text('PASSWORD: $password'),
        Text('ID: $id'),
      ],
    );
  }
}
