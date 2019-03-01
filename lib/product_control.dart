import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  final Function updateProduct; // store the reference to a function
  ProductControl(this.updateProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      color: Theme.of(context).primaryColor, // 调用context的primaryColor属性，和app的theme保持一致
      onPressed: () {
        updateProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
      },
      child: Text('Add Product'),
    );
  }
}