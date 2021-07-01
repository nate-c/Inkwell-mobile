import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';


class Authentication with ChangeNotifier{

  UriConstants uc = new UriConstants();

  Future register(String username, String password, String firstname, String lastname) async
  {
    final Uri uri = Uri.parse(uc.registerUri);

      final response = await http.post(uri, body: json.encode(
          {
            'un' : username,
            'pw' : password,
            'firstname' : firstname,
            'lastname' : lastname,
          }
      )
      );
      return response.statusCode;

  
  }

  Future<String?> logIn(String username, String password) async
  {
    final Uri uri = Uri.parse(uc.authUri);

      final response = await http.post(uri, body: json.encode(
          {
            'un' : username,
            'pw' : password,
          }
      )
      );
      
      if(response.statusCode == 200) return response.body;
      return null;
  }
}

