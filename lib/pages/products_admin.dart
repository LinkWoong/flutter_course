import 'package:flutter/material.dart';
import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {

  final Function addProduct;
  final Function deleteProduct;

  const ProductsAdminPage(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2, //how many tabs will it have
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Drawer'),
                ),
                ListTile(
                  title: Text('Go back to the products page'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/products'); // '/' route has been registered in the main.dart file
                    // However, the list of products will be cleared. The reason for that is replacement of navigation stack.
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Manage Product Page'),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(icon: Icon(Icons.list), text: 'My Product'),
            ]),
          ),
          body: TabBarView(
            // Note that the num of widgets should equal to the length in DefaultTabController, and AppBar
              children: <Widget>[
                ProductCreatePage(addProduct),
                ProductListPage()
              ])
      ),
    );
  }
}
