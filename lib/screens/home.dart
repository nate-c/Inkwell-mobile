// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
import 'package:inkwell_mobile/models/routeArguments.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/tickerSearchObject.dart';
import '../constants/colorConstants.dart';
import 'addmoney.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  MyHomeState createState() {
    return MyHomeState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
      initialRoute: RoutesConstants.homeRoute,
      routes: {
        RoutesConstants.addMoneyRoute: (context) => MyAddMoney(),
      },
    );
  }
}

@override
class MyHomeState extends State<Home> {
  // final User _user;
  String? _token;
  // final int _amount;
  int _investedValue = 0;
  int _availableToInvest = 0;
  int _portfolioValue = 0;

  // Array<String> _searchResults;
  List<String> _searchResults = [];
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

  getUserInvestments() async {
    var token = await storage.read(key: 'jwt');
    var userName = await storage.read(key: 'username');
    Uri uri = Uri.parse(UriConstants.getUserInvestmentsUri);

    var response = await http.post(uri, headers: {
      'authorization': token.toString()
    }, body: {
      'username': userName.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        _investedValue = 1;
      });
    } else {
      ResponseHandler().handleError(response, context);
    }
  }

  navigateToCompanyPage(String company) {
    int shares = 0;
    Navigator.pushNamed(context, RoutesConstants.companyPageRoute,
        arguments: CompanyScreenArguments(company, shares));
  }

  setInitialStateVariables() async {
    // var amount = await storage.read(key: 'amount');
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'jwt');
    _availableToInvest = int.parse(amount.toString());
    _investedValue = 0;
    _portfolioValue = _investedValue + _availableToInvest;
    _token = token.toString();
    setState(() {});
    getAccountInfo();
  }

  void getAccountInfo() async {
    Uri uriReg = Uri.parse(UriConstants.getAccountBalanceUri);
    var user_id = await storage.read(key: 'user_id');
    var response = await http.post(uriReg, headers: {
      'authorization': _token.toString()
    }, body: {
      'user_id': user_id.toString(),
    });
    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.body["data"]);
      // var responseData = await jsonDecode(response.body.toString())["data"];
      // int data = responseData["account_id"];
      // print(data);
      // print(responseData['account_id']);
      // Int accountId = json
      // storage.write(
      //     key: "account_id", value: responseData["data"]["account_id"]);
      // _availableToInvest =
      //     int.parse(responseData["data"]["account_id"].toString());
      // setState(() {});
    }
  }

  List<Widget> getSearchResultsList() {
    List<Widget> searchResults = [];
    if (_searchResults.length > 0) {
      searchResults.add(
        Center(
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Text(
                  "Search Results:",
                  style: TextStyle(fontSize: 18),
                ))),
      );
    }
    for (int i = 0; i < _searchResults.length; i++) {
      String ticker = _searchResults[i].split(":")[0];
      var newWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                color: ColorConstants.textFieldBox,
                width: 325,
                margin: EdgeInsets.all(5),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: InkWell(
                      child: GestureDetector(

                          // onTap: navigateToCompanyPage(ticker),
                          child: Text(
                        _searchResults[i],
                        key: new Key(_searchResults[i]),
                        style: TextStyle(fontSize: 15),
                      )),
                    ))),
          )
        ],
      );
      searchResults.add(newWidget);
    }
    return searchResults;
  }

  void search() async {
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
      var searchResultsArray = jsonDecode(response.body.toString())["data"];
      List<String> updatedSearchResults = [];
      for (int i = 0; i < searchResultsArray.length; i++) {
        String viewString = searchResultsArray[i]["symbol"] +
            ' : ' +
            searchResultsArray[i]["name"];
        updatedSearchResults.add(viewString);
      }
      ResponseHandler().handleError(response, context);
      _searchResults = updatedSearchResults;

      setState(() {});
    }
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Text("Available To Invest    -     ",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                              "\$" +
                                  _availableToInvest
                                      .toStringAsFixed(2)
                                      .replaceAllMapped(
                                          new RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'),
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Text("Already Invested        -     ",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                              "\$" +
                                  _investedValue
                                      .toStringAsFixed(2)
                                      .replaceAllMapped(
                                          new RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'),
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Text(
                          "Portfolio Value           -     ",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                              "\$" +
                                  _portfolioValue
                                      .toStringAsFixed(2)
                                      .replaceAllMapped(
                                          new RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'),
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('navigate to account details page');
                      Navigator.pushNamed(
                          context, RoutesConstants.myProfileRoute);
                    },
                    // shape: ShapeBorder.lerp(1, 1, 1),
                    child: Text(
                      'View Details'.toUpperCase(),
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
                  ),
                  Container(
                      width: 300,
                      margin: new EdgeInsets.all(15),
                      color: ColorConstants.textFieldBox,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: TextFormField(
                            controller: _searchController,
                            onEditingComplete: () async {
                              search();
                              hideKeyboard(context);
                            },
                            decoration: InputDecoration(
                                labelText:
                                    "Search by company names or ticker...",
                                labelStyle: TextStyle(
                                    color: ColorConstants.textInTextField),
                                border: InputBorder.none),
                            style: TextStyle(
                                color: ColorConstants.bodyText, fontSize: 15),
                          ))),
                  Container(
                      height: 200,
                      width: 380,
                      child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [...getSearchResultsList()],
                              )))),
                  Container(
                    height: 50,
                  ),
                  Container(
                    margin: new EdgeInsets.all(15),
                    color: ColorConstants.textFieldBox,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesConstants.addMoneyRoute);
                      },
                      label: Text(
                        'Add Money'.toUpperCase(),
                        style: TextStyle(fontSize: 17),
                      ),
                      icon: const Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding: EdgeInsets.all(10),
                      )),
                ]))));
  }
}
