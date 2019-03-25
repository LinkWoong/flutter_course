import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/scoped_models/main.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      // instantiate once, then pass it around in widget tree implicitly without doing manual wire up
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple,
            fontFamily: 'Oswald'),
        // Auth page is always the first page
        // home: AuthPage(),
        // register named routes, so page navigation could be implemented using name identifier
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) =>
              ProductsAdminPage(model), // identifier, a named route
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
                builder: (BuildContext context) =>
                    ProductPage(index));
          }
          return null;
        },
        // This executes when onGenerateRoute fails, it is a default route
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),
    );
  }
}
