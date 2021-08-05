// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/models/investmentObject.dart';
import '../models/User.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/tickerSearchObject.dart';
import 'package:expandable/expandable.dart';
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

  InvestmentObject inv = new InvestmentObject();

  var totalInvestmentValue = '';
  List<String> _investments = [];
  List<String> updatedInvestments = [];
  // InvestmentObject i = new InvestmentObject(_shares, _ticker, _averagePrice, _currentPrice);

   getUserInvestments() async {
    var token = await storage.read(key: 'token');
    // var userName = await storage.read(key: 'username');
    Uri uriInv = Uri.parse(UriConstants.getUserInvestmentsUri);
    var response = await http.post(uriInv, headers: {
      'authorization': token.toString()
    }, body: {
        'shares': inv.shares.toString(),
        'ticker': inv.ticker,
        'average_price': inv.averagePrice.toString(),
        'current_price': inv.currentPrice.toString(),
    });
    if (response.statusCode == 200) {
      print(response.body);
    }
    return _investments;
    }
   
  
Iterable <Widget> getInvestmentsWidget(){
    List<Widget> investments = [];
      if (_investments.length > 0){ 
        for (int i = 0; i < _investments.length; i++){
        investments.add(
            ExpandablePanel(
                    header: Text('Stocks', style: TextStyle(fontSize: 25),),
                    collapsed: Text(_investments[0], style: TextStyle(fontWeight: FontWeight.w300)),
                    expanded: Text(_investments[i], key: new Key(_investments[i]) , softWrap: true, style: TextStyle(fontSize: 18),), 
                  ));
          }
        } else{ 
            Container();
        }
      return getInvestmentsWidget();
  }

  setInitialStateVariables() async {
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'token');

    setState(() {
      _investedValue = int.parse(amount.toString());
      _token = token.toString();
    });
    
  }

@override
void initState(){
      setInitialStateVariables();
      getUserInvestments();
      super.initState();
    }

@override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () => getUserInvestments());
    
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Text('Current Value'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [  
                Text('\$', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)), //TODO: change invested value to current value after API is done
                Text(_investedValue.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), style: TextStyle(fontSize: 35)),
                Text('↑', style: TextStyle(fontSize: 40, color: ColorConstants.greenLink, fontWeight: FontWeight.w800), textAlign: TextAlign.start,),
              ]
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [
                Text('Invested Value: '.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),  
                Text('\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                Text(_investedValue.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), style: TextStyle(fontSize: 20)),
               
              ]
            ),
             SizedBox(height: 100), //TODO: remove when chart widget is complete
          // Column(
          // children: [...getInvestmentsWidget()],
          // ),
          ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: ColorConstants.expandArrows,
            iconSize: 30,
            collapseIcon: CupertinoIcons.chevron_up_circle,
            expandIcon: CupertinoIcons.chevron_down_circle,
            useInkWell: true,
            tapHeaderToExpand: true,
            
          ),
              child: Container(
              color: ColorConstants.expandable,
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
                child: Column(
                  children: <Widget> [
                    ...getInvestmentsWidget()
                  ],

              )
            )
          ),

          ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: ColorConstants.expandArrows,
            iconSize: 30,
            collapseIcon: CupertinoIcons.chevron_up_circle,
            expandIcon: CupertinoIcons.chevron_down_circle,
            useInkWell: true,
            tapHeaderToExpand: true,
            
          ),
              child: Container(
              color: ColorConstants.expandable,
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
                child: ExpandablePanel(
                  header: Text('Sectors', style: TextStyle(fontSize: 25),),
                  collapsed: Text('Information Technology...', style: TextStyle(fontWeight: FontWeight.w300)),
                  expanded: Text('Information Technology\nIndustrials', softWrap: true, style: TextStyle(fontSize: 18),),
                
                )
              )
              ),

          ]
        ),
        )
      )
    );
  }
}
