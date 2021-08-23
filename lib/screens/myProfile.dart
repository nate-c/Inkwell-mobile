// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/tradeConfirmation.dart';
import 'package:inkwell_mobile/widgets/dropdown.dart';
import 'package:inkwell_mobile/models/investmentObject.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
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
  String list = '';
  // final int _amount;
  static int? investedValue;
  static var totalInvestmentValue;
  List _investments = [];
  // []TickerSearchObject _results;
  // final String _searchValue;
  //TODO: add function that changes value on homepage
  final TextEditingController _searchController = TextEditingController();
  static final storage = new FlutterSecureStorage();

  setInitialStateVariables() async {
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'token');

    setState(() {
      investedValue = int.parse(amount.toString());
      _token = token.toString();
      totalInvestmentValue = double.parse(investedValue.toString());
    });
  }

  Future getUserInvestments() async {
    var token = await storage.read(key: 'jwt');
    var userName = await storage.read(key: 'username');
    Uri uriInv = Uri.parse(UriConstants.getUserInvestmentsUri);
    var response = await http.post(uriInv, headers: {
      'Authorization': token.toString(),
    }, body: {
      'username': userName,
    });

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body.toString())['investments'];
        for (Map<String, dynamic> i in data) {
          _investments.add(new InvestmentObject.fromJson(i));
        }
        
        for (int i = 0; i < _investments.length; i++) {
          final nDataList = _investments[i];
          list = nDataList.ticker +
              '\n' +
              'Shares: ' +
              nDataList.shares.toString() +
              '\n' +
              'Average Price: \$' +
              nDataList.averagePrice.toStringAsFixed(2) +
              '\n' +
              'Current Price: \$' +
              nDataList.currentPrice.toStringAsFixed(2);
          totalInvestmentValue = (investedValue! +
              (_investments
                  .map((s) => s.shares * (s.currentPrice - s.averagePrice))
                  .reduce((accumulator, currentValue) =>
                      accumulator + currentValue)) as double);
        }
      });
    } else {
      ResponseHandler().handleError(response, context);
      throw Exception('Failed to load investments');
    }
  }

  @override
  void initState() {
    setInitialStateVariables();
    getUserInvestments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: ColorConstants.appBarBackground,
            automaticallyImplyLeading: false,
            actions: [
              Theme(
                data: Theme.of(context).copyWith(
                    dividerColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.white)),
                child: new Dropdown(),
              )
            ]),
        backgroundColor: ColorConstants.background,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Current Value'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('\$',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight
                                      .w300)), //TODO: change invested value to current value after API is done
                          Text(
                              totalInvestmentValue
                                  .toStringAsFixed(2)
                                  .replaceAllMapped(
                                      new RegExp(
                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},'),
                              style: TextStyle(fontSize: 35)),
                          Text(
                            '↑',
                            style: TextStyle(
                                fontSize: 40,
                                color: ColorConstants.greenLink,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.start,
                          ),
                        ]),
                    SizedBox(height: 20),
                    Text('Investment Value: '.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('\$',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300)),
                          Text(
                              investedValue.toString().replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(fontSize: 30)),
                        ]),
                    SizedBox(
                        height:
                            100), //TODO: remove when chart widget is complete
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
                              header: Text('Stocks',
                                  style: TextStyle(
                                    fontSize: 25,
                                  )),
                              collapsed: Text(
                                '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 0),
                                maxLines: 1,
                              ),
                              expanded: Text(
                                list,
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                            ))),
                  ]),
            )));
  }
}
