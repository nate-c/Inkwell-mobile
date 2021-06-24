import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'uriConstants.dart';


class Authentication extends UriConstants with ChangeNotifier{

  Future<void> register(String username, String password, String firstname, String lastname) async
  {
    final Uri uri = Uri.parse(this.registerUri);

    try{
      final response = await http.post(uri, body: json.encode(
          {
            'un' : username,
            'pw' : password,
            'firstname' : firstname,
            'lastname' : lastname,
            'returnSecureToken' : true,
          }
      ));
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
    final Uri uri = Uri.parse(this.authUri);

    try{
      final response = await http.post(uri, body: json.encode(
          {
            'un' : username,
            'pw' : password,
            'returnSecureToken' : true,
          }
      ));
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

