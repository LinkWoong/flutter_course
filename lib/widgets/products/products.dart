import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_card.dart';

// detail page
class Products extends StatelessWidget {
  // Why Stateless? Because change does not happened here
  // It happened in product_manager.dart file

  // default display while no products being added
  Widget _buildProductLists(List<Product> products) {
    Widget productCard = Center(child: Text('No products found'));
    if (products.length > 0) {
      productCard = ListView.builder(
          // ListView在item个数未知的情况下表现很差，ListView.builder则可以停止渲染已经跳过的部分
          // ListView.builder接收一个函数
          itemBuilder: (BuildContext context, int index) =>
              ProductCard(products[index], index),
          itemCount: products.length);
    }else{
      productCard = Container();
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    // this function will execute whenever model changes(data changes)
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductLists(model.displayProducts); // avoid accepting data as arguments(otherwise codes will be infinite)
    });
    /*
    return products.length > 0 ?
    ListView.builder(itemBuilder: _buildProductItem, itemCount: products.length) :
    Center(child: Text('No products found'));
    */
  }
}
