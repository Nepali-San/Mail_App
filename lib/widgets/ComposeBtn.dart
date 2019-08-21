import 'package:flutter/material.dart';
import 'package:mail_app_practise/MessageComponse.dart';

class ComposeBtn extends StatelessWidget {
  const ComposeBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        String intention = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageCompose(),
          ),
        );

        print(intention);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Your message was composed with $intention"),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
