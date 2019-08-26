import 'dart:convert';

import 'package:mail_app_practise/model/message.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MessageService {
  static Future<List<Message>> browse({String status = 'important'}) async {
    //load the json file.
    // String content = await rootBundle.loadString('data/message.json');

    String url = status == 'important'
        ? "http://www.mocky.io/v2/5d5d4f4d330000078057b924"
        : "http://www.mocky.io/v2/5d61641432000049008e60c5";

    http.Response response = await http.get(url);
    String content = response.body;

    //decode the json, since first symbol is square bracket , our json is the "list of dynamic" so it return list<dynamic>
    //if first symbol was { then it would return Map<String,dynamic>.

    List<dynamic> collection = json.decode(content);

    //use named contructor to typecast the json into object.
    List<Message> _messages =
        collection.map((json) => Message.fromJson(json)).toList();

    // above contructor does the same task as below constructor.
    //   messages = collection
    //       .map((json) => Message(
    //             subject: json['subject'],
    //             body: json['body'],
    //           ))
    //       .toList();
    // });

    return _messages;
  }
}
