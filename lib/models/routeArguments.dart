import 'package:flutter/material.dart';
import 'package:inkwell_mobile/models/investmentObject.dart';

class CompanyScreenArguments {
  final InvestmentObject investmentObject;
  // final String ticker;
  // final int shares;

  // CompanyScreenArguments(this.ticker, this.shares, this.investmentObject);
  CompanyScreenArguments(this.investmentObject);
}

class TradeCompletionScreenArguments {
  final InvestmentObject investmentObject;
  final String tradeType;

  TradeCompletionScreenArguments(this.investmentObject, this.tradeType);
}
