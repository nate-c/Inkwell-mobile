import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/addmoney.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/moneyConfirmation.dart';
import 'package:inkwell_mobile/screens/myProfile.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/screens/company.dart';
import 'package:inkwell_mobile/screens/resetPassword.dart';
import 'package:inkwell_mobile/screens/tradeConfirmation.dart';
import 'package:provider/provider.dart';
import 'constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'package:inkwell_mobile/constants/assetConstants.dart';
import 'utils/authentication.dart';
import 'providers/stateProvider.dart';

//WEEK 7 RELEASE
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // TO DO: fix this as it causes memory leaks ie.
          // per https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProvider-class.html
          ChangeNotifierProvider.value(
            value: Authentication(),
          ),
          ChangeNotifierProvider(create: (context) => StateProvider()),
        ],
        child: MaterialApp(
          title: 'Inkwell',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          home: MyHomePage(title: 'Inkwell'),
          routes: {
            RoutesConstants.homeRoute: (context) => Home(),
            RoutesConstants.addMoneyRoute: (context) => MyAddMoney(),
            RoutesConstants.loginRoute: (context) => MyLogin(),
            RoutesConstants.registerRoute: (context) => MyRegistration(),
            RoutesConstants.moneyConfirmRoute: (context) => MoneyConfirmation(),
            RoutesConstants.myProfileRoute: (context) => MyProfile(),
            RoutesConstants.companyPageRoute: (context) => Company(),
            RoutesConstants.tradeConfirmationPageRoute: (context) =>
                TradeConfirmation(),
            RoutesConstants.confirmationPopUpRoute: (context) =>
               ConfirmationPopUp(),
            RoutesConstants.tradeConfirmationPopUpRoute: (context) =>
               TradeConfirmationPopUp(),
            RoutesConstants.resetPasswordRoute: (context) =>
               ResetPassword(),
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(0xFF011240),
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Image(
                  image: AssetImage(AssetConstants.logoPath),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                )),
            SizedBox(
              height: 60,
            ),
            Text(
              "Welcome To".toUpperCase(),
              style: TextStyle(fontSize: 34),
            ),
            Text("Inkwell".toUpperCase(),
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800)),
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesConstants.registerRoute);
                },
                child: Text(
                  'Register'.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorConstants.button,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesConstants.loginRoute);
                },
                child: Text(
                  'Log in'.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorConstants.background,
                  side: BorderSide(
                    width: 1.0,
                    color: ColorConstants.bodyText,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
