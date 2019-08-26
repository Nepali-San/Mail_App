import 'package:http/http.dart' as http;
import 'package:mail_app_practise/model/contacts.dart';
import 'dart:convert';

class ContactService {
  static String _url = 'https://jsonplaceholder.typicode.com/users';

  static Future browse() async {
    http.Response res = await http.get(_url);
    String content = res.body;
    List collection = json.decode(content);

    List<Contact> _contacts =
        collection.map((json) => Contact.fromJson(json)).toList();

    return _contacts;
  }
}

// void main() async {
//   List result = await ContactService.browse();
//   print(result);
// }
