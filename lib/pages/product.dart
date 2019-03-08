import 'package:flutter/material.dart';
import '../widgets/ui_elements/title_default.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;

  ProductPage(this.title, this.imageUrl, this.description, this.price);
  // passing data from external
  // final List<Map<String, dynamic>> products;
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

  Widget _buildAddressPriceRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style:
          TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        Text(
          '\$' + price.toString(),
          style:
          TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Replace the homepage, so return a new scaffold
    // However, when clicking the default return button which locates on upper left corner, the returned value would be null
    // To solve this issue, wrap the scaffold in a WillPopScope() widget.
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
                Container(
                    padding: EdgeInsets.all(10.0), child: TitleDefault(title)),
                _buildAddressPriceRow(),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                  ),
                ),
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
