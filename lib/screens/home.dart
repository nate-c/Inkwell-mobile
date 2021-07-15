// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;
import '../constants/uriConstants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/tickerSearchObject.dart';
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
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => MyHomePage(title: 'Inkwell'),
        // '/': (context) => MyApp(),
        '/addmoney': (context) => MyAddMoney(),
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
  // []TickerSearchObject _results;
  // final String _searchValue;
  //TODO: add function that changes value on homepage
  final TextEditingController _searchController = TextEditingController();
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // getUserInvestments();
    setInitialStateVariables();
  }

  getUserInvestments() async {
    var token = await storage.read(key: 'token');
    var userName = await storage.read(key: 'username');
    Uri uriReg = Uri.parse(UriConstants.getUserInvestments);

    var response = await http.post(uriReg, headers: {
      'authorization': token.toString()
    }, body: {
      'username': userName,
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
    });
  }

  search() async {
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
      var resultsArray = [];
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
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
              alignment: Alignment.centerRight,
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/addmoney');
              },
              icon: const Icon(Icons.add)),
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
