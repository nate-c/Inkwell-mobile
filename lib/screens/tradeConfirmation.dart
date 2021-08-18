import 'dart:convert';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:flutter/services.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
import 'package:provider/provider.dart';

void main() => runApp(TradeConfirmation());

class StockTradeConfirmation extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deposit Money to Inkwell',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorConstants.bodyText,
              displayColor: ColorConstants.bodyText,
            ),
      ),
      home: TradeConfirmation(),
      routes: {
        RoutesConstants.tradeConfirmationRoute: (context) => Home(),
      },
    );
  }
}

class TradeConfirmation extends StatelessWidget {
  TradeConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.background,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: ColorConstants.appBarBackground,
          title: Text('Summary'),
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
                  Text('Deposit Summary',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                      '\$ ' +
                          MyAddMoney.moneyamtController.text.replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},'),
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: Text(
                      'From [Insert Bank] to Inkwell account'.toUpperCase(),
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
                    String? user = await storage.read(key: 'user_id');
                    var userId = int.parse(user!);
                    var amount =
                        double.parse(MyAddMoney.moneyamtController.text);
                    var response =
                        await MyAddMoneyState().addmoney(userId, amount);

                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPopUp()));
                    }
                    ResponseHandler().handleError(response, context);
                  },
                  child: Text('Deposit'.toUpperCase()),
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
  var amount = MyAddMoney.moneyamtController.text;

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
                  amount.toString() +
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
