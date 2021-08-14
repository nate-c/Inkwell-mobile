import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/models/investmentObject.dart';
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
    if(response.statusCode == 200){
      final data = jsonDecode(response.body.toString())['investments'];
      print(data);
        for(Map<String,dynamic> i in data){
          _investments.add(InvestmentObject.fromJson(i));
        }

      for (int i = 0; i < _investments.length; i++){ 
        final nDataList = _investments[i];
        list = nDataList.ticker + '\n' + 'Shares: ' + nDataList.shares.toString() 
        + '\n' + 'Average Price: \$' + nDataList.averagePrice.toString() + '\n' + 'Current Price: \$' + nDataList.currentPrice.toString();
        totalInvestmentValue = (MyProfileState.investedValue! + (_investments.map((s) => s.shares * (s.currentPrice - s.averagePrice)).reduce((accumulator, currentValue) => accumulator + currentValue)) as double);
        return list;
      }
    } else {
      throw Exception('Failed to load investments');
    }
    }
}
