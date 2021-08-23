import 'dart:convert';
import 'dart:core';
import 'dart:html';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/myProfile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

// @JsonSerializable(explicitToJson: true)

List<InvestmentObject> modelUserFromJson(String str) =>
    List<InvestmentObject>.from(
        json.decode(str).map((x) => InvestmentObject.fromJson(x)));
String modelUserToJson(List<InvestmentObject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvestmentObject {
  int shares;
  String ticker;
  double averagePrice;
  double currentPrice;

  InvestmentObject(
      {required this.shares,
      required this.ticker,
      required this.averagePrice,
      required this.currentPrice});

  // InvestmentObject.fromInvestmentObject(InvestmentObject obj) {
  //   this.shares = obj.shares;
  //   this.ticker = obj.ticker;
  //   this.averagePrice = obj.averagePrice;
  //   this.currentPrice = obj.currentPrice;
  // }
  factory InvestmentObject.fromJson(Map<String, dynamic> parsedJson) {
    return new InvestmentObject(
        shares: parsedJson['shares'],
        ticker: parsedJson['ticker'],
        averagePrice: double.parse(parsedJson['average_price'].toString()),
        currentPrice: parsedJson['current_price']);
  }

  void updateCurrentPrice(double price) {
    currentPrice = price;
  }

  Map<String, dynamic> toJson() => {
        'shares': shares,
        'ticker': ticker,
        'average_price': averagePrice,
        'current_price': currentPrice,
      };

  @override
  toString() {
    String string = '{ \n' +
        'shares:' +
        shares.toString() +
        '\n ticker: ' +
        ticker +
        '\n average_price: ' +
        averagePrice.toString() +
        '\n current_price: ' +
        currentPrice.toString() +
        '\n }';
    return string;
  }
}
