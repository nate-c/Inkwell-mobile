import 'dart:convert';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inkwell_mobile/constants/uriConstants.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:inkwell_mobile/screens/register.dart';
import 'package:inkwell_mobile/screens/home.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyAddMoney());



class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'Deposit Money to Inkwell',
          theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          home: MyAddMoney(),
          initialRoute: '/',
          routes: {
            // '/': (context) => MyHomePage(title: 'Inkwell'),
            '/login': (context) => MyLogin(),
            '/register': (context) => MyRegistration(),
            '/home': (context) => Home(),
            // '/company': (context) => MyRegistration(),
            // '/completedTrade': (context) => MyRegistration(),
            // '/profile': (context) => MyRegistration(),
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

TextEditingController _moneyamtController = TextEditingController();
final storage = new FlutterSecureStorage();



class _MyAddMoneyState extends State<MyAddMoney> {

void _showSuccessDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xFF011240),
        title: Text('Success'),
        titleTextStyle: TextStyle(color: Colors.red[300]),
        content: Text(msg),
        contentTextStyle: TextStyle(color: Colors.white),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
          )
        ],
      )
    );
  }
   

Future<String?> addmoney(int? userId, int amount) async{
  Uri balance = Uri.parse(UriConstants().getAddMoneyUri);
  var response = await http.post(balance, body: {
    "user_id": userId,
    "amount": amount,
    } );
    if (response.statusCode == 200) {
      _showSuccessDialog("\$" + amount.toString() +  " added into your account.");
      return response.body;
    }

}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: const Color(0xFF011240),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      backgroundColor: Colors.transparent,
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
            color: const Color(0xFF071A4A),
            child: TextFormField(
              style: TextStyle(
                fontSize: 30.0,                 
              ),
              keyboardType: TextInputType.number,
              controller: _moneyamtController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  prefixText: "\$ ",
                  prefixStyle: TextStyle(color: Colors.white, fontSize: 24),
                  hintText: "0.00",
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 24),
                  labelText: "Enter Money Amount",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 21),
                )
              ),
            ),
            Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children:  <Widget> [ 
              Container(
              width: 300,
              child: Text('From [Insert Bank]'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              InkWell( 
                  child: Text('Change Bank'.toUpperCase(), style: TextStyle(color: const Color(0xFF05F240), fontSize: 15),),
                  onTap: (){
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>MoneyConfirmation()));
              },
              child: Text('Confirm'.toUpperCase()),
              style: ElevatedButton.styleFrom(
              primary: Color(0xFF002179), 
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
            
            ),),),
          ],
      ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MoneyConfirmation extends StatelessWidget {
  MoneyConfirmation({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: const Color(0xFF011240),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      backgroundColor: Colors.transparent,
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
  
            children:  <Widget> [ 
              Text('Deposit Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('\$ ' + _moneyamtController.text, style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),
              SizedBox(height: 10),
              Container(
              width: 300,
              child: Text('From [Insert Bank] to Inkwell account'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              
            ],
        ),
        Container(
        width: 300,
        margin: new EdgeInsets.all(15),
        child: ElevatedButton(
              onPressed: () async {
                var userId = await storage.read(key: "userId");
                var amount = int.parse(_moneyamtController.text);
                _MyAddMoneyState().addmoney(int.parse(userId!), amount);
              },
              child: Text('Deposit'.toUpperCase()),
              style: ElevatedButton.styleFrom(
              primary: Color(0xFF002179), 
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
            
            ),),),
          ],
      ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
