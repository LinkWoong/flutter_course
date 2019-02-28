import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';
import 'package:flutter/rendering.dart';
import './pages/home.dart';

main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
} // void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<String> _products = [
    'Food Tester'
  ]; // Create new card when pressing the button

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
        ),
        home: HomePage());
  }
}
