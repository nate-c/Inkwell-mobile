
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ResponseHandler {

  handleError(Response response) async {
   
   var statusNum = response.statusCode; 

   switch(statusNum){
     case 200: {print(response);}
     break;

     case 500: {print ("Internal System Error");}
     break; 

     case 401: {print ("Invalid Token Error");}
     break;

     case 403: {print("Unauthorized Access");}
    
    }return response;
  }
// handleSuccess(){}


}