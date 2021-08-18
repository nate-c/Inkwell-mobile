
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/utils/tokenexpiration.dart';

class ResponseHandler {

  handleError(Response response, BuildContext context) async {
  
   var statusNum = response.statusCode; 

   switch(statusNum){
     case 200: {print(response);}
     break;

     case 500: {print ("Internal System Error");
     }
     break; 

     case 401: {
       isTokenExpired(response, context);
       print ("Invalid Token Error");
       MyRegistrationState().showErrorDialog("Your token is invalid");
       Navigator.pushNamed(context, RoutesConstants.loginRoute);
       }

     break;

     case 403: {
       print("Unauthorized Access");
       MyRegistrationState().showErrorDialog("You have unauthorized access");
       Navigator.pushNamed(context, RoutesConstants.loginRoute);
     }
    
    }return response;
  }
// handleSuccess(){}


}