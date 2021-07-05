import 'package:flutter/material.dart';
import 'package:inkwell_mobile/utils/authentication.dart';
import 'package:inkwell_mobile/screens/login.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/authentication.dart';


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
    'first_name': '',
    'last_name': '',

  };

@override
class MyRegistrationState extends State<MyRegistration> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xFF011240),
        title: Text('An Error Occured'),
        titleTextStyle: TextStyle(color: Colors.red[300]),
        content: Text(msg),
        contentTextStyle: TextStyle(color: Colors.white),
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


  bool _passwordVisible = false;

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
        child: SingleChildScrollView(  
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
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: "First Name", 
                  labelStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['first_name'] = value!;
          }
        ))),
          
        Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: "Last Name", 
                  labelStyle: TextStyle(color: Color(0xFFF2F2F2)), 
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['last_name'] = value!;
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
                  labelText: "Username", 
                  labelStyle:  TextStyle(color: Color(0xFFF2F2F2)),
                  hintText: "Enter a Username", 
                  hintStyle: TextStyle(color: Colors.blue[200]),
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
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: "Password", 
                  labelStyle:  TextStyle(color: Color(0xFFF2F2F2)),
                  hintText: "Enter a Password", 
                  hintStyle: TextStyle(color: Colors.blue[200]), 
                  suffixText: "*",
                  suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                      ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                          _passwordVisible = !_passwordVisible;
                      });
             },
            ),
          
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
        onSaved: (value) {
            _authData['pw'] = value!;
          }
        ))),
      
       Container(
            width: 300,
            margin: new EdgeInsets.all(15),
            color: const Color(0xFF071A4A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: TextFormField(
                obscureText: !_passwordVisible,
                controller: _confirmpassController,
                validator: (value){
                              if(_confirmpassController.text.isEmpty)
                                   return 'Empty';
                              if(_confirmpassController.text != _passwordController.text)
                                   return 'Password Does Not Match';
                            return null;
                  },
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle:  TextStyle(color: Color(0xFFF2F2F2)),
                  suffixText: "*",
                  suffixStyle: TextStyle(color: Color(0xFFF13D3C)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                      ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                          _passwordVisible = !_passwordVisible;
                      });
             },
            ),
          
                  border: InputBorder.none
        ),
        style: TextStyle(color: Colors.white, fontSize: 15),
      
          //TODO: write function to check if passwords match
        
        ))),
          ElevatedButton(
            onPressed: () async {
              var username = _usernameController.text;
              var password = _passwordController.text;
              var firstname = _firstnameController.text;
              var lastname = _lastnameController.text;

              int maxlength = 50;
              if (username.isEmpty) {
              var errorMessage = 'Please enter some text.';
              _showErrorDialog(errorMessage);
            } 
            else if (password.isEmpty) {
              var errorMessage = 'Please enter some text.';
              _showErrorDialog(errorMessage);
            } 
            else if (username.length > maxlength) {
                  var errorMessage = 'The maximum length must be 50 characters or less. Please try again.';
                  _showErrorDialog(errorMessage);
            }
            else if (password.length > maxlength) {
                  var errorMessage = 'The maximum length must be 50 characters or less. Please try again.';
                  _showErrorDialog(errorMessage);
            }
            else if (_confirmpassController.text != _passwordController.text) {
                  var errorMessage = 'Password Does Not Match';
                  _showErrorDialog(errorMessage);
            }
            else{
                  var response = await Authentication().register(username, password, firstname, lastname);
                  if(response == 201)
                    _showErrorDialog("Success! Your account was created. Log in now.");
                  else if(response == 409)
                    _showErrorDialog("That username is already registered. Please try to sign up using another username or log in if you already have an account.");  
                  else {
                    _showErrorDialog("An unknown error occurred.");
                  }
                }
            },
            child: Text('Register'.toUpperCase(), style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF002179), 
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
            )
          ),
        ],
      ),
    ))));
  }
}

 
