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
  static final String tradeConfirmationRoute = '/myprofile';
  static final String companyPageRoute = '/company';
  static final String tradeConfirmationPageRoute = '/tradeConfirmation';
  static final String confirmationPopUpRoute = '/confirmationPopUp';
  static final String tradeConfirmationPopUpRoute = '/confirmationPopUp';
  static final String resetPasswordRoute = '/resetpassword';
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
  }
}
