import 'package:flutter/widgets.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';

class Provider extends InheritedWidget {
  final ContactManager data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static ContactManager of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).data;
  }

  //for immutable inheritedwidget we return false.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
