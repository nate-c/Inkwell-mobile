import 'dart:convert';
import 'package:http/http.dart' as http;
import 'uriConstants.dart';


class Authentication extends UriConstants {

   void register (String username, String password, String firstname, String lastname) async{
    final Uri uri = Uri.parse(this.registerUri);
    final response = await http.post(uri, body: json.encode({
      'un': username,
      'pw': password,
      'firstname': firstname,
      'lastname': lastname,
    })

    );
    final responseData = json.decode(response.body);
  }
}