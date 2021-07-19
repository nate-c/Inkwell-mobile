import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/addmoney.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/myProfile.dart';
import 'package:inkwell_mobile/screens/register.dart'; 

class RoutesConstants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp (
  routes: {
    '/' : (context) => Home(),
    '/addMoney': (context) => MyAddMoney(),
    '/register': (context) => MyRegistration(),
     '/login': (context) => MyLogin(),
     '/moneyConfirmation' : (context) => MoneyConfirmation(),
     '/myprofile' : (context) => MyProfile(),
  });

  }
}