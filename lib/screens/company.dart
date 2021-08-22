// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:inkwell_mobile/models/routeArguments.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import '../models/User.dart';
import 'package:inkwell_mobile/models/investmentObject.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/colorConstants.dart';
import 'package:inkwell_mobile/widgets/dropdown.dart';
import 'package:inkwell_mobile/constants/assetConstants.dart';

// void main() => runApp(Company());

class Company extends StatelessWidget {
  // final InvestmentObject _investmentObject;// = null;

  // @override
  // CompanyState createState() {
  //   return CompanyState();
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CompanyScreenArguments;
    var io = args.investmentObject;
    print('io');
    print(io);
    var ticker = io?.ticker != null ? io?.ticker.toString() : '';
    var shares = io?.shares;
    void sellStock() {}
    void buyStock() {}
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstants.appBarBackground,
          actions: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: new Dropdown(),
            )
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
                  Container(
                    height: 100,
                    margin: new EdgeInsets.fromLTRB(15, 15, 15, 0),
                    // padding: EdgeInsets.all(20),
                    child: Center(child: Text('IMAGE GOES HERE')),
                  ),
                  Container(
                      height: 50,
                      // padding: EdgeInsets.all(20),
                      margin: new EdgeInsets.fromLTRB(15, 0, 15, 15),
                      // color: ColorConstants.textFieldBox,
                      child: Center(child: Text(ticker.toString()))),
                  Container(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: AssetImage(AssetConstants.demoChartPath),
                        width: 100,
                        height: 250,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      )),
                  Container(
                      padding: EdgeInsets.all(5),
                      height: 100,
                      child: Row(
                        children: [
                          if (shares != null && shares > 0)
                            ElevatedButton(
                                onPressed: () {
                                  buyStock();
                                },
                                child: Text(
                                  'Buy'.toUpperCase(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorConstants.button,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                )),
                          ElevatedButton(
                              onPressed: () {
                                sellStock();
                              },
                              child: Text(
                                'Sell'.toUpperCase(),
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorConstants.button,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                              )),
                        ],
                      ))
                ]))));
  }
}

// @override
// class CompanyState extends State<Company> {
//   // final User _user;
//   String? _token;
//   // final int _amount;

//   // Array<String> _searchResults;
//   // []TickerSearchObject _results;
//   // final String _searchValue;
//   //TODO: add function that changes value on homepage
//   final TextEditingController _searchController = TextEditingController();
//   final storage = new FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     // print(args);
//     // getUserInvestments();
//     setInitialStateVariables();
//     // getAccountInfo();
//   }

//   setInitialStateVariables() async {
//     // var amount = await storage.read(key: 'amount');
//     var token = await storage.read(key: 'jwt');

//     _token = token.toString();
//     setState(() {});
//   }

//   Widget build(BuildContext context) {
//     return new Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: ColorConstants.appBarBackground,
//           actions: <Widget>[
//             PopupMenuButton<int>(
//               color: ColorConstants.expandable,
//               icon: Icon(Icons.menu),
//               itemBuilder: (context) => [
//                 PopupMenuItem<int>(
//                     value: 0,
//                     child: Text(
//                       "Home",
//                       style: TextStyle(color: ColorConstants.bodyText),
//                     )),
//                 PopupMenuItem<int>(
//                     value: 1,
//                     child: Text(
//                       "View Portfolio",
//                       style: TextStyle(color: ColorConstants.bodyText),
//                     )),
//                 PopupMenuItem<int>(
//                     value: 2,
//                     child: Text(
//                       "Add Money",
//                       style: TextStyle(color: ColorConstants.bodyText),
//                     )),
//               ],
//               onSelected: (item) => SelectedItem(context, item),
//             ),
//             // IconButton(
//             // alignment: Alignment.centerRight,
//             // color: ColorConstants.bodyText,
//             // onPressed: () {
//             //   Navigator.pushNamed(context, '/myprofile');
//             // },
//             // icon: const Icon(Icons.person),)
//           ],
//         ),
//         backgroundColor: ColorConstants.background,
//         body: Container(
//             color: ColorConstants.background,
//             // height: 100,
//             margin: EdgeInsets.all(15), //originally 24
//             // padding: EdgeInsets.only(top: 0),
//             alignment: Alignment.center,
//             child: Center(
//                 // widthFactor: 100,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                   Container(
//                     height: 50,
//                     child: Text('texe'),
//                   ),
//                   Container(
//                     margin: new EdgeInsets.all(15),
//                     color: ColorConstants.textFieldBox,
//                   ),
//                 ]))));
//   }
// }
