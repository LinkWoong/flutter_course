import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_models/main.dart';
import '../widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final int productIndex;
  ProductPage(this.productIndex);

  Widget _buildAddressPriceRow(double price){
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
        child: ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
          final Product product = model.allProducts[productIndex];
          return Scaffold(
              appBar: AppBar(
                title: Text('Product detail'),
              ),
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.center, // from top to bottom
                crossAxisAlignment:
                CrossAxisAlignment.center, // from left to right
                children: <Widget>[
                  Image.network(product.image),
                  Container(
                      padding: EdgeInsets.all(10.0), child: TitleDefault(product.title)),
                  _buildAddressPriceRow(product.price),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      product.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ));
        }),
        // The onWillPop argument receives a function that concerns about left upper corner return button.
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(
              false); // -> you're allowed to leave, but true will trigger another pop action
        });
  }
}
