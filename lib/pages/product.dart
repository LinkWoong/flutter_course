import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  // passing data from external
  final String title;
  final String imageUrl;

  _showWarningDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('This action cannot be undone'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  ProductPage(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        _showWarningDialog(context);
                      }, // return to previous page, true -> Delete the page
                    )),
              ],
            )),
        // The onWillPop argument receives a function that concerns about left upper corner return button.
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(
              false); // -> you're allowed to leave, but true will trigger another pop action
        });
  }
}
