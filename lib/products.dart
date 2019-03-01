import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  // Why Stateless? Because change does not happened here
  // It happened in product_manager.dart file

  final List<Map<String, String>> products;
  final Function deleteProduct; // receive the
  // constructor
  Products(this.products, {this.deleteProduct}); // optional arguments

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push<bool>(
                        // the bool here, is to store the returned value of ProductPage
                        // push methods receive 2 arguments, 1 is context and the other is MaterialPageRoute()
                        // The latter provides animation for page navigation, and it also takes an argument which is builder method
                        // The builder method contains the page that you want to jump to.
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ProductPage(
                              products[index]['title'],
                              products[index]
                                  ['image']), // passing a data into ProductPage
                        )).then((bool value) {
                      // then method: a function which is eventually executed when event occurs(navigation finished)
                      // based on the value that passed back
                      if (value) {
                        deleteProduct(index);
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  // default display while no products being added
  Widget _buildProductLists() {
    Widget productCard = Center(child: Text('No products found'));
    if (products.length > 0) {
      productCard = ListView.builder(
          // ListView在item个数未知的情况下表现很差，ListView.builder则可以停止渲染已经跳过的部分
          // ListView.builder接收一个函数
          itemBuilder: _buildProductItem,
          itemCount: products.length);
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductLists(); // make sure the build method returns something.
    /*
    return products.length > 0 ?
    ListView.builder(itemBuilder: _buildProductItem, itemCount: products.length) :
    Center(child: Text('No products found'));
    */
  }
}
