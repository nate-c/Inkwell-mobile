// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:inkwell_mobile/models/routeArguments.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/colorConstants.dart';

// void main() => runApp(Company());

class Company extends StatefulWidget {
  @override
  CompanyState createState() {
    return CompanyState();
  }

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CompanyScreenArguments;
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
      initialRoute: RoutesConstants.homeRoute,
      routes: {
        // RoutesConstants.addMoneyRoute: (context) => MyAddMoney(),
      },
    );
  }
}

@override
class CompanyState extends State<Company> {
  // final User _user;
  String? _token;
  // final int _amount;
  int _investedValue = 0;
  int _availableToInvest = 0;
  int _portfolioValue = 0;

  // Array<String> _searchResults;
  // []TickerSearchObject _results;
  // final String _searchValue;
  //TODO: add function that changes value on homepage
  final TextEditingController _searchController = TextEditingController();
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // getUserInvestments();
    setInitialStateVariables();
    // getAccountInfo();
  }

  setInitialStateVariables() async {
    // var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'jwt');
    _availableToInvest = 0;
    // int.parse(amount.toString());
    _investedValue = 0;
    _portfolioValue = _investedValue + _availableToInvest;
    _token = token.toString();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstants.appBarBackground,
          actions: <Widget>[
            PopupMenuButton<int>(
              color: ColorConstants.expandable,
              icon: Icon(Icons.menu),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "Home",
                      style: TextStyle(color: ColorConstants.bodyText),
                    )),
                PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      "View Portfolio",
                      style: TextStyle(color: ColorConstants.bodyText),
                    )),
                PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      "Add Money",
                      style: TextStyle(color: ColorConstants.bodyText),
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
            // IconButton(
            // alignment: Alignment.centerRight,
            // color: ColorConstants.bodyText,
            // onPressed: () {
            //   Navigator.pushNamed(context, '/myprofile');
            // },
            // icon: const Icon(Icons.person),)
          ],
        ),
        backgroundColor: ColorConstants.background,
        body: Container(
            color: ColorConstants.background,
            // height: 100,
            margin: EdgeInsets.all(15), //originally 24
            // padding: EdgeInsets.only(top: 0),
            alignment: Alignment.center,
            child: Center(
                // widthFactor: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Text(
                            "Available To Invest - ",
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            _availableToInvest.toString(),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Text(
                          "Already Invested - ",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            _investedValue.toString(),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Text(
                          "Portfolio Value - ",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            _portfolioValue.toString(),
                          )),
                    ],
                  ),
                  FloatingActionButton.extended(
                    heroTag: new Hero(
                      tag: 'view details',
                      child: Text(''),
                    ),
                    onPressed: () {
                      print('navigate to account details page');
                      // Navigator.pushNamed(
                      //     context, RoutesConstants.addMoneyRoute);
                    },
                    // shape: ShapeBorder.lerp(1, 1, 1),
                    label: const Text('View Details'),
                    backgroundColor: Color.fromARGB(0, 255, 0, 0),
                  ),
                  Container(
                    height: 50,
                  ),
                  Container(
                    margin: new EdgeInsets.all(15),
                    color: ColorConstants.textFieldBox,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesConstants.addMoneyRoute);
                    },
                    label: const Text('Add Money'),
                    icon: const Icon(Icons.add),
                    backgroundColor: ColorConstants.button,
                  ),
                ]))));
  }
}
