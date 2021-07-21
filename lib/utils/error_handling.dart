
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Error {

  errorHandling(int response) async {
   
    if (response == 500){
      return "Internal System Error";
    }
    if (response == 401){
      return "Invalid Token Error";
    }
    if (response == 403){
      return "Unauthorized Access";
    }
    if (response == 200){
      return "Success";
    }
    return response;
  }

}