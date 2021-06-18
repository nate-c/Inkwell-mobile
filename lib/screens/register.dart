import 'package:flutter/material.dart';

void main() => runApp(MyRegistration());

class MyRegistration extends StatefulWidget {
  @override
  MyRegistrationState createState() {
    return MyRegistrationState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
@override
class MyRegistrationState extends State<MyRegistration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
        body: Center(
            child: Form(
      key: _formKey,
      child: Column(
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
          //TODOS: Add redirection to login page
          // FIX THIS:
          _buildFormField("First Name"),
          _buildFormField("Last Name"),
          _buildFormField("User Name"),
          _buildFormField("Passcode"),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
            },
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
        // The validator receives the text that the user has entered.
      ));
}
