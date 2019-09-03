import 'package:flutter/widgets.dart';

// * DirtyProvider is a mutable inheritedWidget,
// * it uses stateful widget to mutate/change it's data.

// ! we don't use dirty provider in this project , it is just for practising
// ! purpose.

class DirtyProvider extends StatefulWidget {
  final Widget child;

  DirtyProvider({this.child});

  @override
  _DirtyProviderState createState() => _DirtyProviderState();

  static _DirtyProviderState of(BuildContext context, {bool subscribe = true}) {
    return subscribe
        ? (context.inheritFromWidgetOfExactType(_DirtyProvider)
                as _DirtyProvider)
            .data
        : (context.ancestorInheritedElementForWidgetOfExactType(_DirtyProvider)
                as _DirtyProvider)
            .data;
  }
}

class _DirtyProviderState extends State<DirtyProvider> {
  // * counter is the state to be mutated.

  /*
   * unlike immutable provider we don't need 
   * to provide data(as param), since it handles it's data/state
   * within it's stateful widget.   
   * */

  int counter;

  @override
  void initState() {
    counter = 1;
    super.initState();
  }

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DirtyProvider(
      data: this,
      child: widget.child,
    );
  }
}

// * Inherited widget is a private class.
class _DirtyProvider extends InheritedWidget {
  final _DirtyProviderState data;

  _DirtyProvider({Key key, this.data, Widget child})
      : super(key: key, child: child);

  // * Rem: return true for a mutable inhWidget
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
