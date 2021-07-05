import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'dart:convert' show json, base64, ascii;

class Authentication with ChangeNotifier{

  // UriConstants uc = new UriConstants();
  
  Future <int> register(String username, String password, String firstname, String lastname) async
  {
      Uri uriReg = Uri.parse(UriConstants().registerUri);
 
      var response = await http.post(uriReg, body: json.encode(
          {
            'un' : username,
            'pw' : password,
            'first_name' : firstname,
            'last_name' : lastname,
          }
      )
      );
      return response.statusCode;

  
  }
  
  Future <String?> logIn(String username, String password) async
  {
    Uri uriLog = Uri.parse(UriConstants().authUri);
 
      var response = await http.post(uriLog, body: json.encode(
          {
            'un': username,
            'pw': password,
          }
      )
      );
      
      if(response.statusCode == 200) return response.body;
      return null;
  }
}

