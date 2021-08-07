
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
      : shares = json['shares'],
        ticker = json['ticker'],
        averagePrice = json['average_price'],
        currentPrice = json['current_price'];

  Map<String, dynamic> toJson() => {
        'shares': shares,
        'ticker': ticker,
        'average_price': averagePrice,
        'current_price': currentPrice,
        
      };
}


List <InvestmentObject> _investments = [];

class API {
  static final storage = new FlutterSecureStorage();
 
   static Future<void> getUserInvestments() async {
   
    var token = await storage.read(key: 'jwt');
    var userName = await storage.read(key: 'username');
    Uri uriInv = Uri.parse(UriConstants.getUserInvestmentsUri);
    http.Response response = await http.get(uriInv, headers: {
      'Authorization': token.toString(),
      "Accept": "application/json"
    });
    print(response.body);
    if (response.statusCode == 200) {
      _investments = (json.decode(response.body) as List)
          .map((i) => InvestmentObject.fromJson(i))
          .toList(growable:true);
    } else {
      throw Exception('Failed to load investments');
    }
    }
   

}

class GetInvestmentsWidget extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
  API.getUserInvestments();
  return Container(
            height: 200,
            width: 300,
   child:  new ListView.builder(
      itemCount: _investments.length,
      itemBuilder: (context, index) {
        // for (int i = 0; i < _investments.length; i++){
            return ExpandablePanel(
                    header: Text('Stocks', style: TextStyle(fontSize: 25),),
                    collapsed: Text(_investments[0].ticker.toString(), style: TextStyle(fontWeight: FontWeight.w300, color: ColorConstants.bodyText)),
                    expanded: Text(_investments[index].ticker.toString() + '/n' + "Shares:" + _investments[index].shares.toString() + '/n' +
                    "Average Price:" + _investments[index].averagePrice.toString() + '/n' +
                    "Current Price:" + _investments[index].currentPrice.toString() + '/n', key: new Key(_investments[index].toString()) , softWrap: true, style: TextStyle(fontSize: 18, color: ColorConstants.bodyText),), 
                  );  
 
      }));
  }}