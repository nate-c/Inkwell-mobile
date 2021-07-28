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
  int? _investedValue;
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
    }
  }

  setInitialStateVariables() async {
    var amount = await storage.read(key: 'amount');
    var token = await storage.read(key: 'token');

    setState(() {
      _investedValue = int.parse(amount.toString());
      _token = token.toString();
      _searchResults = [];
    });
  }

  Widget getTextWidgets() {
    // Widget getTextWidgets(List<String> strings) {
    return new Row(
        children: _searchResults.map((item) => new Text(item)).toList());
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
      // var jsonResponse = convert.jsonDecode(response.body);
      var resultsArray = ['test1', 'test2'];
      setState(() {
        _searchResults = resultsArray.toList();
      });
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
                  Navigator.pushNamed(context, RoutesConstants.myProfileRoute);
                },
                icon: const Icon(Icons.person)),

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
                            "JJJ",
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
                            "JJJ",
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
                            "JJJ",
                          )),
                    ],
                  ),

                  FloatingActionButton.extended(
                    onPressed: () {
                      print('navigate to account details page');
                      // Navigator.pushNamed(
                      //     context, RoutesConstants.addMoneyRoute);
                    },
                    // shape: ShapeBorder.lerp(1, 1, 1),
                    label: const Text('View Account Details'),
                    backgroundColor: Color.fromARGB(0, 0, 0, 0),
                  ),
                  // Container(
                  //     // width: 300,
                  //     margin: new EdgeInsets.all(15),
                  //     color: ColorConstants.textFieldBox,
                  //     child: Row(
                  //       children: [
                  //         Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 2),
                  //             child: TextFormField(
                  //               controller: _searchController,
                  //               decoration: InputDecoration(
                  //                   labelText:
                  //                       "Search by company names or ticker...",
                  //                   labelStyle: TextStyle(
                  //                       color: ColorConstants.textInTextField),
                  //                   border: InputBorder.none),
                  //               style: TextStyle(
                  //                   color: ColorConstants.bodyText,
                  //                   fontSize: 15),
                  //             )),
                  //       ],
                  //     ))
                  // ,
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
                  // FloatingActionButton.extended(
                  //   onPressed: () {
                  //     search();
                  //   },
                  //   label: const Text('Search'),
                  //   backgroundColor: ColorConstants.button,
                  // ),
                  // getTextWidgets(),
                  // FloatingActionButton.extended(
                  //   onPressed: () {
                  //     Navigator.pushNamed(
                  //         context, RoutesConstants.addMoneyRoute);
                  //   },
                  //   label: const Text('Add Money'),
                  //   icon: const Icon(Icons.add),
                  //   backgroundColor: ColorConstants.button,
                  // ),
                ])))

        // body:
        // Container(
        //   width: 100,
        //   height: 100,
        //   margin: EdgeInsets.all(15), //originally 24
        //   // padding: EdgeInsets.only(top: 0),
        //   alignment: Alignment.center,
        //   // transform: Transform.rotate(...),
        //   child: Column(
        //     // child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Container(
        //         margin: new EdgeInsets.all(15),
        //         alignment: Alignment.topCenter,
        //         child: Align(
        //             alignment: Alignment.topCenter,
        //             child: Text(
        //               "Current Value".toUpperCase(),
        //               style: TextStyle(
        //                 fontSize: 20,
        //               ),
        //               textAlign: TextAlign.center,
        //             )),
        //       ),
        //       Text("1800"),
        //       Container(
        //           // width: 300,
        //           margin: new EdgeInsets.all(15),
        //           color: ColorConstants.textFieldBox,
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        //           )),
        //       Text("Investment Value"),
        //       Text("1600"),
        //       Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 1, vertical: 35)),
        //       Container(
        //           // width: 300,
        //           margin: new EdgeInsets.all(15),
        //           color: ColorConstants.textFieldBox,
        //           child: Padding(
        //               padding:
        //                   EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        //               child: TextFormField(
        //                 controller: _searchController,
        //                 decoration: InputDecoration(
        //                     labelText: "Search by company names or ticker...",
        //                     labelStyle: TextStyle(
        //                         color: ColorConstants.textInTextField),
        //                     border: InputBorder.none),
        //                 style: TextStyle(
        //                     color: ColorConstants.bodyText, fontSize: 15),
        //               ))),
        //       FloatingActionButton.extended(
        //         onPressed: () {
        //           Navigator.pushNamed(context, RoutesConstants.addMoneyRoute);
        //         },
        //         label: const Text('Add Money'),
        //         icon: const Icon(Icons.add),
        //         backgroundColor: ColorConstants.button,
        //       ),
        //     ],
        //     // ),
        //   ),
        // )
        );
  }
}
