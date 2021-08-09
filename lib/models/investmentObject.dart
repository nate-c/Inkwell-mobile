
import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

@JsonSerializable(explicitToJson: true)

class InvestmentObject {
 
 int shares;
 String ticker;
 int averagePrice;
 int currentPrice;

InvestmentObject(this.shares, this.ticker, this.averagePrice, this.currentPrice);


InvestmentObject.fromJson(Map<String, dynamic> json)
      : shares = json['account']['shares'],
        ticker = json['account']['ticker'],
        averagePrice = json['account']['average_price'],
        currentPrice = json['account']['current_price'];

  Map<String, dynamic> toJson() => {
        'shares': shares,
        'ticker': ticker,
        'average_price': averagePrice,
        'current_price': currentPrice,
        
      };
}


List _investments = [];

class API {
  static final storage = new FlutterSecureStorage();
  static String list = '';
  static Future getUserInvestments() async {
   
    var token = await storage.read(key: 'jwt');
    var userName = await storage.read(key: 'username');
    Uri uriInv = Uri.parse(UriConstants.getUserInvestmentsUri);
    var response = await http.post(uriInv, headers: {
      'Authorization': token.toString(),
    }, body: {
      'username' : userName,
    });
    print(response.body);
    if (response.statusCode == 200) {
      _investments = (json.decode(response.body.toString())["account"]);
      for (int i = 0; i < _investments.length; i++){
      list = _investments[i]['ticker'] + '\n' + 'Shares: ' + _investments[i]['shares'].toString() 
      + '\n' + 'Average Price: \$' + _investments[i]['average_price'].toString();
      return list;
      }
    } else {
      throw Exception('Failed to load investments');
    }
    }
   

}



 
