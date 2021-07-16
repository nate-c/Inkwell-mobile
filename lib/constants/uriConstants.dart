import 'package:flutter/material.dart';

class UriConstants {
  static final useProdUri = false;
  static final prodUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/';
  static final localUri = 'http://localhost:8080/';
  static final String baseUri = useProdUri ? prodUri : localUri;
  static final String authUri = baseUri + 'auth/login/';
  static final String registerUri = baseUri + 'auth/register/';
  static final String getTickerInfoUri = baseUri + 'search/getTickerInfo/';
  static final String getAllTickersUri = baseUri + 'search/getAllTickers/';
  static final String getFilteredTickersUri =
      baseUri + 'search/getMatchingTickers/';
  static final String executeTradeUri = baseUri + 'trades/executeTrade/';
  static final String getTradesUri = baseUri + 'trades/getTrades/';
  static final String getAddMoneyUri =
      baseUri + 'accounts/updateAccountBalance';
  static final String getUserInvestmentsUri =
      baseUri + 'accounts/getAllInvestments';
}
