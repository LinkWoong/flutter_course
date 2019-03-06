import 'package:flutter/material.dart';

// detail page
class Products extends StatelessWidget {
  // Why Stateless? Because change does not happened here
  // It happened in product_manager.dart file

  final List<Map<String, dynamic>> products;
  // final Function deleteProduct; // receive the deleted product
  // constructor
  Products(this.products); // optional arguments

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          // SizedBox(height: 10.0,),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // mainAxisAlignment depends on Row or Col you used
                children: <Widget>[
                  Flexible(
                    flex: 10,
                    child: Text(
                      products[index]['title'],
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald'),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Text(
                        '\$${products[index]['price'].toString()}', //Text widget
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(6.0)),
                      padding:
                      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    ),
                  )
                ],
              )),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              child: Text('Union Square, San Francisco'),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(context,
                            '/product/' + index.toString()) // using named route
                        .then((bool value) {
                      if (value) {
                        // deleteProduct(index);
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
