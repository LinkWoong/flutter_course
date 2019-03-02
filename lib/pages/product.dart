import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  // passing data from external
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Replace the homepage, so return a new scaffold
    // However, when clicking the default return button which locates on upper left corner, the returned value would be null
    // To solve this issue, wrap the scafold in a WillPopScope() widget.
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Product detail'),
            ),
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.center, // from top to bottom
              crossAxisAlignment:
                  CrossAxisAlignment.center, // from left to right
              children: <Widget>[
                Image.asset(imageUrl),
                Container(padding: EdgeInsets.all(10.0), child: Text(title)),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text('DELETE'),
                      onPressed: () => Navigator.pop(context,
                          true), // return to previous page, true -> Delete the page
                    )),
              ],
            )),
        // The onWillPop argument receives a function that concerns about left upper corner return button.
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false); // -> you're allowed to leave, but true will trigger another pop action
        });
  }
}
