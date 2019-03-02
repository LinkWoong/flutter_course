import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';
import 'package:flutter/rendering.dart';
import './pages/products.dart';
import './pages/auth.dart';

main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
} // void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
        ),
        // Auth page is always the first page
        home: AuthPage());
  }
}
