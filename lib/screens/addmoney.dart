import 'dart:convert';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inkwell_mobile/constants/colorConstants.dart';
import 'package:flutter/services.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/utils/error_handling.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyAddMoney());

class MyApp extends StatelessWidget {
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
      home: MyAddMoney(),
      routes: {
        RoutesConstants.homeRoute: (context) =>  Home(),
        RoutesConstants.moneyConfirmRoute: (context) => MoneyConfirmation(),
      },
      
    );
  }
}

class MyAddMoney extends StatefulWidget {
  MyAddMoney({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyAddMoneyState createState() => _MyAddMoneyState();
}

TextEditingController _moneyamtController = new TextEditingController();
final storage = new FlutterSecureStorage();

class _MyAddMoneyState extends State<MyAddMoney> {
  

  // ignore: non_constant_identifier_names
  Future addmoney(int userId, int amount) async {
    Uri addMoney = Uri.parse(UriConstants.addMoneyUri);
    var response = await http.post(addMoney, body: {
      "user_id": userId.toString(),
      "amount": amount.toString(),
    });
   
      return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.background,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: ColorConstants.appBarBackground,
          title: Text('Deposit Money to Inkwell'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: new EdgeInsets.all(15),
                color: ColorConstants.textFieldBox,
                child: TextFormField(
                  controller: _moneyamtController,
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      prefixText: "\$ ",
                      prefixStyle: TextStyle(color: ColorConstants.bodyText, fontSize: 24),
                      hintText: "0.00",
                      hintStyle: TextStyle(color: ColorConstants.textInTextField, fontSize: 24),
                      labelText: "Enter Money Amount",
                      labelStyle: TextStyle(color: ColorConstants.bodyText, fontSize: 21),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Text(
                      'From [Insert Bank]'.toUpperCase(),
                      style: TextStyle(color: ColorConstants.bodyText, fontSize: 15),
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Change Bank'.toUpperCase(),
                      style: TextStyle(
                          color: ColorConstants.greenLink, fontSize: 15),
                    ),
                    onTap: () {
                      //Insert way to change bank
                    },
                  ),
                ],
              ),
              Container(
                width: 300,
                margin: new EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesConstants.moneyConfirmRoute);
                  },
                  child: Text('Confirm'.toUpperCase()),
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

class MoneyConfirmation extends StatelessWidget {
  MoneyConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSuccessDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Color(0xFF011240),
              title: Text('Success'),
              titleTextStyle: TextStyle(color: ColorConstants.greenLink),
              content: Text(msg),
              contentTextStyle: TextStyle(color: ColorConstants.bodyText),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesConstants.homeRoute);
                  },
                )
              ],
            ));
  }
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
                  Text('\$ ' + _moneyamtController.text,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: Text(
                      'From [Insert Bank] to Inkwell account'.toUpperCase(),
                      style: TextStyle(color:ColorConstants.bodyText, fontSize: 15),
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
                    int userId = int.parse(user!);
                    int amount = int.parse(_moneyamtController.text);
                    var response = await _MyAddMoneyState().addmoney(userId, amount);
                    ResponseHandler().handleError(response);
                    if (response == 200) {
                    _showSuccessDialog("\$" + amount.toString() + " added into your account.");
                  }
                  Navigator.pushNamed(context, RoutesConstants.homeRoute);
                   
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
