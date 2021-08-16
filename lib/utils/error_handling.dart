
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/utils/tokenexpiration.dart';

class ResponseHandler {

  handleError(Response response, BuildContext context) async {
  
   var statusNum = response.statusCode; 

   switch(statusNum){
     case 200: {print(response);}
     break;

     case 500: {print ("Internal System Error");}
     break; 

     case 401: {
       isTokenExpired(response, context);
       print ("Invalid Token Error");}
     break;

     case 403: {print("Unauthorized Access");}
    
    }return response;
  }
// handleSuccess(){}


}