// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;

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
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'Inkwell'),
        // '/': (context) => MyApp(),
        // '/register': (context) => MyLogin(),
      },
    );
  }
}

@override
class MyHomeState extends State<Home> {
  // User _user;

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.arrow_back)),
        ],
      ),
      backgroundColor: const Color(0xFF011240),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home page')
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) =>MyLogin()));
            //     Navigator.pushNamed(context, '/login');
            //   },
            //   child: Text('Log in'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => MyRegistration()));
            //     Navigator.pushNamed(context, '/register');
            //   },
            //   child: Text('Register'),
            // ),
          ],
        ),
      ),
    );
  }
}
