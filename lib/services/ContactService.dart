import 'package:http/http.dart' as http;
import 'package:mail_app_practise/model/contacts.dart';
import 'dart:convert';

class ContactService {
  static String _url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<Contact>> browse({String query}) async {
    http.Response res = await http.get(_url);
    String content = res.body;
    List collection = json.decode(content);

    Iterable<Contact> _contacts =
        collection.map((json) => Contact.fromJson(json));

    if (query != null && query.isNotEmpty) {
      _contacts = _contacts.where(
        (test) => test.name.toLowerCase().contains(query),
      );
    }

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
