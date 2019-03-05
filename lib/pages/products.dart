import 'package:flutter/material.dart';
import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
  List<Map<String, dynamic>> _products = []; // Create new card when pressing the button
  ProductsPage(this._products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading:
                    false, // false: disable the display of the burger icon
                title: Text('Choose'),
              ),
              ListTile(
                // presents a image on the left, and text under the image
                title: Text('Manage Products'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/admin'); // using named route which is registered in main.dart file
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Easy List'),
        ),
        body: ProductManager(_products));
  }
}
