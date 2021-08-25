
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/widgets/dropdown.dart';

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


class ResetPasswordState extends State<ResetPassword> {
  TextEditingController _usernameController = new TextEditingController();

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
              width: 300,
              margin: new EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                    labelStyle: TextStyle(
                    color: ColorConstants.textInTextField),
                    border: InputBorder.none),
                    style: TextStyle(
                    color: ColorConstants.bodyText, fontSize: 15),
              )
            ),
            ElevatedButton(
              child: Text('Continue'.toUpperCase(), style: TextStyle(color: ColorConstants.bodyText),
                      ),
                style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordSecond()));
              } ,)
          ],
        )
      )

      );
  }
}

class ResetPasswordSecond extends StatelessWidget{
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
              onPressed: () {

              } ,)
          ],
        )
      )

      );
  }
}