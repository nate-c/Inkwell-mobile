import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/register.dart';

import '../main.dart';

void main() => runApp(MyLogin());

class MyLogin extends StatefulWidget {
  @override
  MyLoginState createState() {
    return MyLoginState();
  }
    Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'Inkwell'),
        '/': (context) => MyApp(),
        '/register': (context) => MyRegistration(),
      },
    );
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
      appBar: AppBar( 
        actions: <Widget> [
          IconButton(
            color: Colors.white,
                onPressed: (){ 
                    Navigator.pushNamed(context, '/');
                    }, 
                    icon: const Icon(Icons.arrow_back)),
        ],
      ),
      backgroundColor: const Color(0xFF011240),
        body: Center(
            key: _formKey,
            child: Form(
              child: Column(
                children: <Widget>[
                  
                  Text(
                    "Inkwell".toUpperCase(),
                    style: TextStyle(
                      fontSize: 50,
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
