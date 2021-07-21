import 'package:flutter/material.dart';

class UriConstants {
  static final String baseUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/';
  static final String authUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/auth/login/';
  static final String registerUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/auth/register/';
  static final String getTickerInfoUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/search/getTickerInfo/';
  static final String getAllTickersUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/search/getAllTickers/';
  static final String getFilteredTickersUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/search/getMatchingTickers/';
  static final String executeTradeUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/trades/executeTrade/';
  static final String getTradesUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/trades/getTrades/';
  static final String addMoneyUri =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/accounts/updateAccountBalance';
  static final String getUserInvestments =
      'http://inkwellservices-env.eba-k5w7dcu7.us-east-2.elasticbeanstalk.com/accounts/getAllInvestments';
}