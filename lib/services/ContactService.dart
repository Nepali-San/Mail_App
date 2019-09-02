import 'package:http/http.dart' as http;
import 'package:mail_app_practise/model/contacts.dart';
import 'dart:convert';

class ContactService {
  // ? this is my localhost id , need to deploy
  static String _url = 'http://192.168.100.12:5000/contacts';

  static Future<List<Contact>> browse({String query}) async {
    http.Response res = await http.get('$_url?q=$query');

    String content = res.body;
    List collection = json.decode(content);

    Iterable<Contact> _contacts =
        collection.map((json) => Contact.fromJson(json));

    return _contacts.toList();
  }
}

// * just to check if the above code fetches the data,
// * you may run this file as a seprate dart file, by writing main() as below

/* 
  void main() async {
     List result = await ContactService.browse();
    print(result);
   }
 */
