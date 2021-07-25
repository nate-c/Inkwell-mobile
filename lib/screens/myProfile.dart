// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/tickerSearchObject.dart';
import 'addmoney.dart';

void main() => runApp(MyProfile());

class MyProfile extends StatefulWidget {
  @override
  MyProfileState createState() {
    return MyProfileState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
    );
  }
}

@override
class MyProfileState extends State<MyProfile> {
  // final User _user;
  String? _token;
  // final int _amount;
  int? _investedValue;
  // []TickerSearchObject _results;
  // final String _searchValue;
  //TODO: add function that changes value on homepage
  final TextEditingController _searchController = TextEditingController();
  final storage = new FlutterSecureStorage();


  @override
  void initState() {
    // getUserInvestments();
    setInitialStateVariables();
  }

  getUserInvestments() async {
    var token = await storage.read(key: 'token');
    var userName = await storage.read(key: 'username');
    Uri uriReg = Uri.parse(UriConstants.getUserInvestmentsUri);

    var response = await http.post(uriReg, headers: {
      'authorization': token.toString()
    }, body: {
      'username': userName,
    });
    if (response.statusCode == 200) {
      setState(() {
        _investedValue = 1;
      });
    }
  }

  setInitialStateVariables() async {
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'token');

    setState(() {
      _investedValue = int.parse(amount.toString());
      _token = token.toString();
    });
  }

  search() async {
    // var token = await storage.read(key: 'token');
    Uri uriReg = Uri.parse(UriConstants.getFilteredTickersUri);
    // String searchText = _searchController.text;

    var response = await http.post(uriReg, headers: {
      'authorization': _token.toString()
    }, body: {
      'searchString': _searchController.text,
    });
    if (response.statusCode == 200) {
      print(response.body);
      // var jsonResponse = convert.jsonDecode(response.body);
      var resultsArray = [];
      // for(int i = 0; i < response.body.; i++){

      // }
      //   (for var item in response.data.data){
      //     TickerSearchObject t = new TickerSearchObject(item.ticker, item.name);
      //   }
    }
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarBackground,
        actions: <Widget>[
          IconButton(
              alignment: Alignment.centerRight,
              color: ColorConstants.bodyText,
              onPressed: () {
                Navigator.pushNamed(context, RoutesConstants.addMoneyRoute);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      backgroundColor: ColorConstants.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Text('Current Value'.toUpperCase(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [  
                Text('\$', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
                Text(_investedValue.toString(), style: TextStyle(fontSize: 35)),
                Text('↑', style: TextStyle(fontSize: 40, color: ColorConstants.greenLink, fontWeight: FontWeight.w800), textAlign: TextAlign.start,),
              ]
            ),
             SizedBox(height: 100),
          
          Container(
            width: 300,
            height: 50,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: ColorConstants.textFieldBox,
            child: Text('Stocks', style: TextStyle(fontSize: 20),),
          ),
          Container( //TODO: find out how to do the dropdowns
            width: 300,
            height: 50,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: ColorConstants.textFieldBox,
            child: Text('Sectors', style: TextStyle(fontSize: 20),),
          ),
          Container(
            width: 300,
            height: 50,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: ColorConstants.textFieldBox,
            child: Text('Recurring', style: TextStyle(fontSize: 20),),
          ),
          ]
        ),
        )
    );
  }
}
