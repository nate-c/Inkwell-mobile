import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/login.dart';

import '../main.dart';

void main() => runApp(MyRegistration());

class MyRegistration extends StatefulWidget {
  @override
  MyRegistrationState createState() {
    return MyRegistrationState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'Inkwell'),
        '/': (context) => MyApp(),
        '/register': (context) => MyLogin(),
      },
    );
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
            child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Inkwell".toUpperCase(),
            style: TextStyle(
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Have an account? Log in.",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          //TODOS: Add redirection to login page
          // FIX THIS:
          _buildFormField("First Name", Icon(null)),
          _buildFormField("Last Name", Icon(null)),
          _buildFormField("User Name", Icon(null)),
          _buildFormField("Passcode", Icon(Icons.lock)),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
            },
            child: Text('Register'.toUpperCase(), style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF002179), 
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
            )
          ),
        ],
      ),
    )));
  }
}

@override
_buildFormField(String formInput, Icon iconName) {
  return Container(
      width: 300,
      margin: new EdgeInsets.all(15),
      color: const Color(0xFF071A4A),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: formInput, 
          hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
          suffixIcon: iconName,
          border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        // The validator receives the text that the user has entered.
      )));
}
