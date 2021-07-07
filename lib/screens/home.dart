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
  // final int _amount;
  // final int _investedValue;
  // final String _searchValue;
  final TextEditingController _searchController = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(15),
              alignment: Alignment.topCenter,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Current Value".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
            Text("1800"),

            // child: Text(
            //   "Current Value".toUpperCase(),
            //   style: TextStyle(
            //     fontSize: 30,
            //   ),
            //   textAlign: TextAlign.center,
            // )),
            Container(
                width: 300,
                margin: new EdgeInsets.all(15),
                color: const Color(0xFF071A4A),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  // child: TextFormField(
                  //   controller: _usernameController,
                  //   decoration: InputDecoration(
                  //       labelText: "Username",
                  //       labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                  //       border: InputBorder.none),
                  //   style: TextStyle(color: Colors.white, fontSize: 15),
                  // ))
                )),
            Text("Investment Value"),
            Text("1600"),
            Padding(padding: EdgeInsets.symmetric(horizontal: 1, vertical: 35)),
            Container(
                width: 300,
                margin: new EdgeInsets.all(15),
                color: const Color(0xFF071A4A),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          labelText: "Search by company names or ticker...",
                          labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
                          border: InputBorder.none),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))),
            // Container(
            //     width: 300,
            //     margin: new EdgeInsets.all(15),
            //     color: const Color(0xFF071A4A),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //       // child: TextFormField(
            //       //   controller: _usernameController,
            //       //   decoration: InputDecoration(
            //       //       labelText: "Username",
            //       //       labelStyle: TextStyle(color: Color(0xFFF2F2F2)),
            //       //       border: InputBorder.none),
            //       //   style: TextStyle(color: Colors.white, fontSize: 15),
            //       // ))
            //     )
            //     )
          ],
        ),
      ),
    );
  }
}
