import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/register.dart';
import '/constants/authentication.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

void main() => runApp(MyLogin());

class MyLogin extends StatefulWidget {
  @override
  MyLoginState createState() {
    return MyLoginState();
  }
}

Map<String, String> _authData = {
    'un': '',
    'pw': '',
    'firstname': '',
    'lastname': '',

  };

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
        '/register': (context) => MyRegistration(),
      },
    );
  }


// Define a corresponding State class.
// This class holds data related to the form.
class MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();


void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

Future <void> _submit() async{
  if (!_formKey.currentState!.validate())
  {
    return;
  }
  // _formKey.currentState.save();
  
  try {
  await Provider.of<Authentication>(context, listen: false).logIn(
    _authData['un']!,
   _authData['pw']!);
   } catch (error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
   
}
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
                color: Colors.blue,
                onPressed: () {
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
                  InkWell(
                    child: Text("Don't have an account? Register.",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center),
                    onTap: () => Navigator.pushNamed(context, '/register'),
                  ),
                  Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Username", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['un'] = value!;
          }
        ))),

        Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Password", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  suffixIcon: Icon(Icons.lock),
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['pw'] = value!;
          }
        ))),
                  ElevatedButton(
                      onPressed: () async{
                        _submit();
                      },
                      child: Text(
                        'Log in'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF002179),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      )),
                ],
              ),
            )));
  }
}
