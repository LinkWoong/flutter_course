import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget{
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text(
        '\$$price', //Text widget
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(6.0)),
      padding:
      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
    );
  }}