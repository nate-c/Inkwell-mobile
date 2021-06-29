import 'package:flutter/material.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/authentication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(MyRegistration());

class MyRegistration extends StatefulWidget {
  @override
  MyRegistrationState createState() {
    return MyRegistrationState();
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
        '/': (context) => MyApp(),
        '/register': (context) => MyLogin(),
      },
    );
  }
}

// Define a corresponding State class.
// This class holds data related to the form.

Map<String, String> _authData = {
    'un': '',
    'pw': '',
    'firstname': '',
    'lastname': '',

  };

@override
class MyRegistrationState extends State<MyRegistration> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


specificValidate(){
  // ignore: unnecessary_statements
  (value) {
    int maxlength = 50;
      if (value == null || value.isEmpty) {
            var errorMessage = 'Please enter some text.';
            _showErrorDialog(errorMessage);
          } 
      if (value.length > maxlength) {
            var errorMessage = 'The maximum length must be 50 characters or less. Please try again.';
            _showErrorDialog(errorMessage);
      }
     return value;
  };
}

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

Future <void> _submit() async{

    var username = _usernameController.text;
    var password = _passwordController.text;
    var jwt = await Authentication.register(username, password); 
  specificValidate();

  if (!_formKey.currentState!.validate())
  {
    return;
  }
 _formKey.currentState!.save();
 Provider.of<Authentication>(context, listen: false).register(
    _authData['un']!,
   _authData['pw']!, 
   _authData['firstname']!,
   _authData['lastname']!);
   
}

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar( 
        backgroundColor: Colors.transparent,
        actions: <Widget> [
          IconButton(
            color: Colors.white,
                onPressed: (){ 
                    Navigator.pushNamed(context, '/');
                    }, 
                    icon: const Icon(Icons.arrow_back)),
        ],
      ),
      backgroundColor: const Color(0xFF011240),
      
        body: Center(
            child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Inkwell".toUpperCase(),
            style: TextStyle(
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          InkWell(
            child: Text(
              "Have an account? Log in.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center),
                onTap: () => Navigator.pushNamed(context, '/login'),
            ),
      
          Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "First Name", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['firstname'] = value!;
          }
        ))),
          
        Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Last Name", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['lastname'] = value!;
          }
        ))),

        Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  suffixText: "*",
                  suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                  hintText: "Username", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)),
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['un'] = value!;
          }
        ))),

        Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password", 
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  suffixText: "*",
                  suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                  suffixIcon: Icon(Icons.lock),
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['pw'] = value!;
          }
        ))),
      
          ElevatedButton(
            onPressed: () async {
              _submit();
            },
            child: Text('Register'.toUpperCase(), style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF002179), 
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
            )
          ),
        ],
      ),
    )));
  }
}


