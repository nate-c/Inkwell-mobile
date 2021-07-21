import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
import '../main.dart';
import '../utils/authentication.dart';

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
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'Inkwell'),
        '/': (context) => MyApp(),
        '/login': (context) => MyLogin(),
      },
    );
  }
}

// Define a corresponding State class.
// This class holds data related to the form.

@override
class MyRegistrationState extends State<MyRegistration> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Color(0xFF011240),
              title: Text('An Error Occured'),
              titleTextStyle: TextStyle(color: Colors.red[300]),
              content: Text(msg),
              contentTextStyle: TextStyle(color: Colors.white),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  void _showSuccessDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: ColorConstants.background,
              title: Text('An Error Occured'),
              titleTextStyle: TextStyle(color: ColorConstants.errorText),
              content: Text(msg),
              contentTextStyle: TextStyle(color: ColorConstants.bodyText),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  bool validatorFn() {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var firstname = _firstnameController.text;
    var lastname = _lastnameController.text;
    if (username.isEmpty ||
        password.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty) {
      _showErrorDialog('Please enter some text.');
      return false;
    }
    if (password.length > 50 || username.length > 50) {
      _showErrorDialog(
          'The maximum length must be 50 characters or less. Please try again.');
      return false;
    }
    if (_confirmpassController.text != password) {
      _showErrorDialog('Password Does Not Match');
      return false;
    }
    return true;
  }

  bool isValid() => validatorFn();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstants.appBarBackground,
          actions: <Widget>[],
        ),
        backgroundColor: ColorConstants.background,
        body: Center(
            child: SingleChildScrollView(
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
              InkWell(
                child: Text("Have an account? Log in.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
              Container(
                  width: 300,
                  margin: new EdgeInsets.all(15),
                  color: const Color(0xFF071A4A),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        controller: _firstnameController,
                        decoration: InputDecoration(
                            suffixText: "*",
                            suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                            labelText: "First Name",
                            labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Container(
                  width: 300,
                  margin: new EdgeInsets.all(15),
                  color: const Color(0xFF071A4A),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                            suffixText: "*",
                            suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                            labelText: "Last Name",
                            labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Container(
                  width: 300,
                  margin: new EdgeInsets.all(15),
                  color: const Color(0xFF071A4A),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            suffixText: "*",
                            suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                            hintText: "Enter a Username",
                            hintStyle: TextStyle(color: Colors.blue[200]),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Container(
                  width: 300,
                  margin: new EdgeInsets.all(15),
                  color: const Color(0xFF071A4A),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                            hintText: "Enter a Password",
                            hintStyle: TextStyle(color: Colors.blue[200]),
                            suffixText: "*",
                            suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              Container(
                  width: 300,
                  margin: new EdgeInsets.all(15),
                  color: const Color(0xFF071A4A),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        controller: _confirmpassController,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                            suffixText: "*",
                            suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ))),
              ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var firstname = _firstnameController.text;
                    var lastname = _lastnameController.text;

                    var response = await Authentication()
                        .register(username, password, firstname, lastname);
                    if (isValid()) {
                      _showSuccessDialog(
                          "Success! You are ready to log in now.");
                    } else {
                      Error().errorHandling(response);
                    }
                  },
                  child: Text(
                    'Register'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0021cc),
                    padding:
                        EdgeInsets.symmetric(horizontal: 125, vertical: 20),
                  )),
            ],
          ),
        ))));
  }
}
