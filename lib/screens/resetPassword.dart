
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/widgets/dropdown.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(ResetPassword());

class ResetPassword extends StatefulWidget {
  @override
  ResetPasswordState createState() {
    return ResetPasswordState();
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
    routes: {
      RoutesConstants.homeRoute: (context) => Home(),
    },
  );
}
final storage = new FlutterSecureStorage();

class ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _oldpwController = new TextEditingController();
  final TextEditingController _confirmnewpwController = new TextEditingController();
  final TextEditingController _newpwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(
          backgroundColor: ColorConstants.appBarBackground,
          actions: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: new Dropdown(),
            )
          ],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Text('Reset Password', style: TextStyle(fontSize: 20, color: ColorConstants.bodyText),),
            Container(
              color: ColorConstants.textFieldBox,
              margin: new EdgeInsets.all(15),
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _oldpwController,
                decoration: InputDecoration(
                  labelText: "Enter Current Password",
                    labelStyle: TextStyle(
                    color: ColorConstants.textInTextField),
                    border: InputBorder.none),
                    style: TextStyle(
                    color: ColorConstants.bodyText, fontSize: 15),
              )
            ),
            Container(
              color: ColorConstants.textFieldBox,
              margin: new EdgeInsets.all(15),
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _newpwController,
                decoration: InputDecoration(
                  labelText: "Enter New Password",
                    labelStyle: TextStyle(
                    color: ColorConstants.textInTextField),
                    border: InputBorder.none),
                    style: TextStyle(
                    color: ColorConstants.bodyText, fontSize: 15),
              )
            ),
             Container(
              color: ColorConstants.textFieldBox,
              width: 300,
              margin: new EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _confirmnewpwController,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                    labelStyle: TextStyle(
                    color: ColorConstants.textInTextField),
                    border: InputBorder.none),
                    style: TextStyle(
                    color: ColorConstants.bodyText, fontSize: 15),
              )
            ),
            ElevatedButton(
              child: Text('Reset Password'.toUpperCase(), style: TextStyle(color: ColorConstants.bodyText),
                      ),
                style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              onPressed: () async{
                  var username = await storage.read(key: 'username');
                  var token = await storage.read(key: 'jwt');
                  var newPassword = _newpwController.text;
                  if(_confirmnewpwController.text == newPassword && newPassword != _oldpwController.text){
                  //Code for URI
                  var response = await http.post('', headers: {
                    'Authorization': token.toString(),
                  }, body: {
                    'un': username,
                    'newpw': newPassword,
                  });
                  if (response.statusCode == 200){
                    showDialog(context: context, builder:(ctx) => AlertDialog(
                      backgroundColor: Color(0xFF011240),
                      title: Text('An Error Occurred'),
                      titleTextStyle: TextStyle(color: Colors.red[300]),
                      content: Text('Password reset successful!'),
                      contentTextStyle: TextStyle(color: Colors.white),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            _oldpwController.clear();
                            _newpwController.clear();
                            _confirmnewpwController.clear();
                  })]));}
                  }})
          ],
        )
      )

      );
  }
}