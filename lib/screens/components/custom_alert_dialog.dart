import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Function onPressed;
  final String title;

  const CustomAlertDialog(
      {Key key,
      this.userNameController,
      this.passwordController,
      this.onPressed,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Username'),
                Expanded(
                  child: TextField(
                    controller: userNameController,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Password'),
                Expanded(
                  child: TextField(
                    controller: passwordController,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: onPressed,
            child: Text(
              'Register User',
            ))
      ],
    );
  }
}
