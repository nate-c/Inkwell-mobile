import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/myProfile.dart';

List _investments = [];

class API {
  
  static final storage = new FlutterSecureStorage();
  static String list = '';
  
  static double totalInvestmentValue = double.parse(MyProfileState.investedValue!.toString());
 
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
      _investments = (json.decode(response.body.toString())["investments"]);
      for (int i = 0; i < _investments.length; i++){
      list = _investments[i]['ticker'] + '\n' + 'Shares: ' + _investments[i]['shares'].toString() 
      + '\n' + 'Average Price: \$' + _investments[i]['average_price'].toString() + '\n' + 'Current Price: \$' + _investments[i]['current_price'].toString();
      totalInvestmentValue = (MyProfileState.investedValue! + (_investments.map((s) => s['shares'] * (s['current_price'] - s['average_price'])).reduce((accumulator, currentValue) => accumulator + currentValue)) as double);
      return list;
      }
    } else {
      throw Exception('Failed to load investments');
    }
    }
}