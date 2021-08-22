import 'dart:convert';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:flutter/services.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/addmoney.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
import 'package:provider/provider.dart';

void main() => runApp(TradeConfirmation());

class TradeConfirmation extends StatefulWidget {
  // This widget is the root of your application.
  @override
  TradeConfirmationState createState() {
    return TradeConfirmationState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
        routes: {
        RoutesConstants.homeRoute: (context) => Home(),
      }
    );
  }
}


int? accountId;
String? ticker;
int? shares;
String? type;
double? buyPrice;
double? sellPrice;
bool? isBuying;
bool? isSelling;
String? tradeType; 


class TradeConfirmationState extends State<TradeConfirmation> {

  // getTradeInfo() async{
  //   var response = await http.post(Uri.parse(UriConstants.executeTradeUri), body: 
  //   {{
  //     "account_id": accountId,
  //     "ticker": ticker,
  //     "shares": shares,
  //     "type": type,
  //     "buy_price": buyPrice,
  //     "sell_price": sellPrice
  //   }});

  //   if (response.statusCode == 200){
  //     if(buyPrice == null){
  //       tradePrice = sellPrice;
  //     } else if(sellPrice == null){
  //       tradePrice = buyPrice;
  //     }
  //     return tradePrice;
  //   }
  // }
 
  // @override
  // void initState(){
  //   // getTradeInfo();
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: ColorConstants.background,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: ColorConstants.appBarBackground,
          title: Text('Trade Summary'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Trade Summary',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                      '\$ ' +
                          ((20 * 100).toString()).replaceAllMapped( //TODO: change when numbers are gathered
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},'),
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
                  SizedBox(height: 10),
                  Container( 
                    width: 300,
                    child: Text(
                      ( "You are " + tradeType.toString()+" \$"+(20 * 100).toString().replaceAllMapped( 
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +" of "+ 
                      ticker.toString() + " at "+ buyPrice.toString() + " which amounts to " + shares.toString() +" shares.").toUpperCase(),
                      style: TextStyle(
                          color: ColorConstants.bodyText, fontSize: 15),
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                margin: new EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () async {
                    var response = await http.post(Uri.parse(UriConstants.executeTradeUri), body: 
                    {{
                      "account_id": accountId,
                      "ticker": ticker,
                      "shares": shares,
                      "type": type,
                      "buy_price": buyPrice,
                      "sell_price": sellPrice
                    }});

                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPopUp()));
                    }
                    ResponseHandler().handleError(response, context);
                  },
                  child: Text('Trade'.toUpperCase()),
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.button,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ConfirmationPopUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Congratulations!".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\$" +
                  20000.toString() +
                  " has been added into your account.".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 100,
            ),
            FloatingActionButton.extended(
              backgroundColor: ColorConstants.button,
              label: Text('Return to Home'.toUpperCase()),
              onPressed: () {
                Navigator.pushNamed(context, RoutesConstants.homeRoute);
                MyAddMoney.moneyamtController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
