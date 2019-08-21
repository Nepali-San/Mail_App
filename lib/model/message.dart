import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message({this.subject, this.body});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static Future<List<Message>> browse() async {
    //load the json file.
    // String content = await rootBundle.loadString('data/message.json');

    http.Response response = await http.get(
        "http://www.mocky.io/v2/5d5d4f4d330000078057b924??mocky-delay=2000ms");
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