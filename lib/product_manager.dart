import 'package:flutter/material.dart';
import 'package:flutter_course/products.dart';

class ProductManager extends StatelessWidget {
  List<Map<String, dynamic>> _products = []; // Create new card when pressing the button
  ProductManager(this._products);

  @override
  Widget build(BuildContext context) {
    // context: It stores the meta data information like the general theme of app
    return Column(children: [
      /*Container(
        margin: EdgeInsets.all(10.0), // space around the button
        // 解释一下，下面child原来是一个RaisedButton，就是有onPressed和setState（因为这个所处的类是个Stateful)
        // 现在想把这个Button wrap成一个独立的类叫product_control。但是这个独立的类不能为Stateful
        // 因为在这个独立的类中并不需要state，在product_manager里面才需要。因为更新的东西Products(_products)在product_manager里
        child: ProductControl(), // passing a function reference to another class for initialization.
      ),*/
      Expanded(
          child: Products(_products)), // expand the full screen, will hit performance issue
    ]);
  }
}