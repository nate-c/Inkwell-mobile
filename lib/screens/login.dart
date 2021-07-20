import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/screens/register.dart';
import '../utils/authentication.dart';
import '../models/User.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

void main() => runApp(MyLogin());

class MyLogin extends StatefulWidget {
  @override
  MyLoginState createState() {
    return MyLoginState();
  }
}

Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: ColorConstants.bodyText,
            displayColor: ColorConstants.bodyText,
          ),
    ),
  );
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyLoginState extends State<MyLogin> {
// Create storage
  final storage = new FlutterSecureStorage();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: ColorConstants.background,
              title: Text('An Error Occured'),
              content: Text(msg),
              titleTextStyle: TextStyle(color: ColorConstants.errorText),
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

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstants.appBarBackground,
          actions: <Widget>[],
        ),
        backgroundColor: ColorConstants.background,
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
                      color: ColorConstants.textFieldBox,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(
                                    color: ColorConstants.textInTextField),
                                border: InputBorder.none),
                            style: TextStyle(
                                color: ColorConstants.bodyText, fontSize: 15),
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
                                labelStyle: TextStyle(
                                    color: ColorConstants.textInTextField),
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
                            style: TextStyle(
                                color: ColorConstants.bodyText, fontSize: 15),
                          ))),
                  ElevatedButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;

                        var returnPayload =
                            await Authentication().logIn(username, password);
                        // Map<String, dynamic> returnPayloadObj =
                        //     jsonDecode(returnPayload.toString());
                        var returnPayloadObj =
                            jsonDecode(returnPayload.toString());
                        print(returnPayloadObj);
                        if (returnPayload != null) {
                          // var newUser =
                          //     new User.fromJson(returnPayloadObj?.User);
                          var jwt = returnPayloadObj["token"];
                          storage.write(key: "jwt", value: jwt);
                          storage.write(
                              key: "username",
                              value: returnPayloadObj["User"]["username"].toString());
                          storage.write(
                              key: "user_id",
                              value: returnPayloadObj["User"]["user_id"]
                                  .toString());
                          storage.write(
                              key: "amount",
                              value: returnPayloadObj["User"]["amount"]
                                  .toString());
                          storage.write(
                              key: "user",
                              value: returnPayloadObj["User"].toString());

                          print(jwt);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          _showErrorDialog(
                              "No account was found matching that username and password.");
                        }
                      },
                      child: Text(
                        'Log in'.toUpperCase(),
                        style: TextStyle(color: ColorConstants.bodyText),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      )),
                ],
              ),
            )));
  }
}
