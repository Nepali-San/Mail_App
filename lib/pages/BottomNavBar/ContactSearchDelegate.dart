import 'package:flutter/material.dart';

class ContactSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    Widget text = query.length < 3
        ? Text("Type atlease 3 characters.")
        : Text("Your query is : $query");

    return Center(
      child: text,
    );
  }
 
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
