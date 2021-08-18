import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';

bool isTokenExpired(Response response, BuildContext context) {
     if (response.statusCode == 401 && response.body == 'expired token'){
       showDialog(context: context, builder: (ctx) => AlertDialog(
              backgroundColor: ColorConstants.background,
              content: Text('Your session has expired.'),
              contentTextStyle: TextStyle(color: ColorConstants.bodyText),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesConstants.loginRoute);
                  },
                )
              ],
            ));
     } else{
       return false;
     }
     return true;
   }