import 'package:flutter/material.dart';
import 'package:inkwell_mobile/screens/addmoney.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:provider/provider.dart';
import 'constants/colorConstants.dart';
import 'package:inkwell_mobile/constants/routeConstants.dart';
import 'utils/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Authentication(),
          )
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
          initialRoute: '/',
          routes: {
          
            RoutesConstants.loginRoute: (context) => MyLogin(),
            RoutesConstants.registerRoute: (context) => MyRegistration(),

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
        child:Column( mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

            Text("Welcome To".toUpperCase(), style: TextStyle(fontSize: 24),),
            Text("Inkwell".toUpperCase(), style: TextStyle(fontSize:40, fontWeight: FontWeight.w800)),
            SizedBox(height: 100,),
            ElevatedButton(
              onPressed: () {
               
                Navigator.pushNamed(context, RoutesConstants.loginRoute);
              },
              child: Text('Log in'.toUpperCase()),
              style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      )
            ),
            ElevatedButton(
              onPressed: () {
              
                Navigator.pushNamed(context, RoutesConstants.registerRoute);
              },
              child: Text('Register'.toUpperCase()),
              style: ElevatedButton.styleFrom(
                        primary: ColorConstants.button,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      )
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
