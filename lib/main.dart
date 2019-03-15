import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';
import 'models/product.dart';

main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
} // void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // dynamic means mixed type
  List<Product> _products = [];

  // lifting the state up
  void _addProduct(Product product) {
    // receive an argument
    setState(() {
      _products.add(product);
    });
  }

  // remove the viewed product
  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _updateProduct(int index, Product product){
    setState(() {
      _products[index] = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple,
          fontFamily: 'Oswald'),
      // Auth page is always the first page
      home: AuthPage(),
      // register named routes, so page navigation could be implemented using name identifier
      routes: {
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) => ProductsAdminPage(
            _addProduct, _updateProduct, _deleteProduct, _products), // identifier, a named route
      },
      // executed when navigated to a named route, which is not registered
      // return a route where we want to go to
      // settings argument actually hold the name we want to navigate to
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          // Note that for split in Dart, the first returned argument of list is always an empty string
          // else, the split is unsuccessful
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index =
              int.parse(pathElements[2]); // parse the String into int
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index].title,
                _products[index].image,
                _products[index].description,
                _products[index].price), // passing a data into ProductPage
          );
        }
      },
      // This executes when onGenerateRoute fails, it is a default route
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}
