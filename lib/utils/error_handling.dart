
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';

class ResponseHandler {

  handleError(Response response, BuildContext context) async {
   bool isTokenExpired() {
     if (response.body == 'expired token'){
       showDialog(context: context, builder: (ctx) => AlertDialog(
              backgroundColor: ColorConstants.background,
              content: Text('You session has expired.'),
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
   var statusNum = response.statusCode; 

   switch(statusNum){
     case 200: {print(response);}
     break;

     case 500: {print ("Internal System Error");}
     break; 

     case 401: {
       isTokenExpired();
       print ("Invalid Token Error");}
     break;

     case 403: {print("Unauthorized Access");}
    
    }return response;
  }
// handleSuccess(){}


}