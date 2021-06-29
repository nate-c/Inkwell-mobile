import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'http_exception.dart';


class Authentication with ChangeNotifier{

  UriConstants uc = new UriConstants();

  Future<void> register(String username, String password, String firstname, String lastname) async
  {
    final Uri uri = Uri.parse(uc.registerUri);

    try{
      final response = await http.post(uri, body: 
          {
            'un' : username,
            'pw' : password,
            'firstname' : firstname,
            'lastname' : lastname,
          }
      );
      final responseData = json.decode(response.body);
//      print(responseData);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }

    } catch (error)
    {
      throw error;
    }
  
  }

  Future<void> logIn(String username, String password) async
  {
    final Uri uri = Uri.parse(uc.authUri);

    try{
      final response = await http.post(uri, body: 
          {
            'un' : username,
            'pw' : password,
          }
      );
      final responseData = json.decode(response.body);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }
//      print(responseData);

    } catch(error)
    {
      throw error;
    }

  }
}

