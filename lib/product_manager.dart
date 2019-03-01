import 'package:flutter/material.dart';
import 'package:flutter_course/products.dart';
import 'package:flutter_course/product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String>
      startingProduct; // why final? because the change of data should happened in the State class
  ProductManager({this.startingProduct}); // 如果是多个，加{}

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products =
      []; // Create new card when pressing the button

  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // lifting the state up
  void _addProducts(Map<String, String> product) {
    // receive an argument
    setState(() {
      _products.add(product);
    });
  }

  // remove the viewed product
  void _deleteProduct(int index){
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // context: It stores the meta data information like the general theme of app
    // TODO: implement build
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0), // space around the button
        // 解释一下，下面child原来是一个RaisedButton，就是有onPressed和setState（因为这个所处的类是个Stateful)
        // 现在想把这个Button wrap成一个独立的类叫product_control。但是这个独立的类不能为Stateful
        // 因为在这个独立的类中并不需要state，在product_manager里面才需要。因为更新的东西Products(_products)在product_manager里
        child: ProductControl(
            _addProducts), // passing a function reference to another class for initialization.
      ),
      Expanded(
          child: Products(
              _products, deleteProduct: _deleteProduct)), // expand the full screen, will hit performance issue
    ]);
  }
}
