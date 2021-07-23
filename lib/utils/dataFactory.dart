import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../constants/uriConstants.dart';
import 'dart:convert' show json, base64, ascii;

class DataFactory {
  // ignore: non_constant_identifier_names
  Future addMoney(int userId, double amount, String token) async {
    Uri addMoneyUrl = Uri.parse(UriConstants.addMoneyUri);

    Response response = await post(addMoneyUrl, headers: {
      'Authorization': token.toString()
    }, body: {
      "user_id": userId,
      "amount": amount,
    });

    return response;
  }
}
