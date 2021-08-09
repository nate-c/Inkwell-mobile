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
  static int? investedValue;
  // []TickerSearchObject _results;
  // final String _searchValue;
  //TODO: add function that changes value on homepage
  final TextEditingController _searchController = TextEditingController();
  final storage = new FlutterSecureStorage();
 
  
  setInitialStateVariables() async {
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'token');

    setState(() {
      investedValue = int.parse(amount.toString());
      _token = token.toString();
    });
    
  }

@override
void initState(){
      setInitialStateVariables();
      API.getUserInvestments();
      super.initState();
    }

@override
  Widget build(BuildContext context) {

    return new Scaffold(
    
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarBackground,
        automaticallyImplyLeading: false,
        actions: <Widget>[

              PopupMenuButton<int>(
              color: ColorConstants.expandable,
              icon: Icon(Icons.menu),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("Home", style: TextStyle(color: ColorConstants.bodyText),)),
                PopupMenuItem<int>(
                    value: 1, child: Text("View Portfolio", style: TextStyle(color: ColorConstants.bodyText),)),
                PopupMenuItem<int>(
                    value: 2,
                    child: Text("Add Money", style: TextStyle(color: ColorConstants.bodyText),)
                      
                    ),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
        ],
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Text('Current Value'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [  
                Text('\$', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)), //TODO: change invested value to current value after API is done
                Text(API.totalInvestmentValue.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), style: TextStyle(fontSize: 35)),
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
                Text(investedValue.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'), style: TextStyle(fontSize: 20)),
               
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
                child: ExpandablePanel(
                  header: Text('Stocks', style: TextStyle(fontSize: 25,)),
                  collapsed: Text('', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 0), maxLines: 1,),
                  expanded: Text(API.list, softWrap: true, style: TextStyle(fontSize: 18),),
                
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
