import 'package:flutter/widgets.dart';

// * Provider is a generic immutable inheritedWidget
// * using it the data provided to the root can easily be accessed by it's childrens

class Provider<T> extends InheritedWidget {
  final T data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static T of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    return (context.inheritFromWidgetOfExactType(type) as Provider).data;
  }

  // * for immutable inheritedwidget we return false.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static Type _typeOf<T>() => T;
}
