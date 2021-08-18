
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/screens/addmoney.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/myProfile.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/utils/authentication.dart'; 

class RoutesConstants {
  static final String homeRoute = '/home';
  static final String addMoneyRoute = '/addMoney';
  static final String registerRoute = '/register';
  static final String loginRoute = '/login';
  static final String moneyConfirmRoute = '/moneyConfirmation';
  static final String myProfileRoute = '/myprofile';
  }

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.pushNamed(context, RoutesConstants.homeRoute);
      break;
    case 1:
      Navigator.pushNamed(context, RoutesConstants.myProfileRoute);
      break;
    case 2: 
      Navigator.pushNamed(context, RoutesConstants.addMoneyRoute);
      break;
    case 3: 
      var response;
      showDialog(context: context, builder:(ctx) =>
        AlertDialog(
            content: Text("Are you sure you want to log out?"),
            backgroundColor: ColorConstants.background,
            contentTextStyle: TextStyle(color:ColorConstants.bodyText),
            actions: <Widget>[
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      response = Response('Logging out...', 401);
                      print(response.body);
                      print(response.statusCode);
                      Navigator.pushNamed(context, RoutesConstants.loginRoute);
                      if (response.statusCode == 401) {
                        showDialog(context: context, builder:(ctx) =>
                          AlertDialog(
                              content: Text("You have successfully logged out."),
                              backgroundColor: ColorConstants.background,
                              contentTextStyle: TextStyle(color:ColorConstants.bodyText),
                              actions: <Widget>[
                                    TextButton(
                                      child: Text('Okay'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(context);
                                      },
                            )]));
                        }
                    },
                  ),
                  TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop(context);
                            },
                  )
          ]));
    

      break;
  }
}
