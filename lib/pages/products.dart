import 'package:flutter/material.dart';
import 'package:flutter_course/scoped_models/main.dart';
import '../widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;
  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage>{
  @override
  initState(){
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading:
                false, // false: disable the display of the burger icon
            title: Text('Choose'),
          ),
          ListTile(
            // presents a image on the left, and text under the image
            leading: Icon(Icons
                .edit), // allows us to output some widget which is put in front of the title
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context,
                  '/admin'); // using named route which is registered in main.dart file
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Easy List'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder:
                  (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  // TODO: Finish onPressed() function
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            )
          ],
        ),
        body: Products());
  }
}
