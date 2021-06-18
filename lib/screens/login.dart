import 'package:flutter/material.dart';

void main() => runApp(MyLogin());

class MyLogin extends StatefulWidget {
  @override
  MyLoginState createState() {
    return MyLoginState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        body: Center(
            key: _formKey,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Inkwell".toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Don't have an account? Register",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  //TODO: Add redirection to registration page
                  _buildFormField('User Name'),
                  _buildFormField('Passcode'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Log in'.toUpperCase()),
                  ),
                ],
              ),
            )));
  }
}

@override
_buildFormField(String formInput) {
  return Container(
      width: 300,
      child: TextFormField(
        decoration: InputDecoration(hintText: formInput),
      ));
}
