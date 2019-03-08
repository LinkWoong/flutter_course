import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/products/price_tag.dart';
import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import 'package:flutter_course/widgets/products/address_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> products;
  final int productIndex;
  ProductCard(this.products, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // mainAxisAlignment depends on Row or Col you used
          children: <Widget>[
            TitleDefault(products['title']),
            SizedBox(
              width: 10.0,
            ),
            // outsourcing the price widget into a separate class
            PriceTag(products['price'].toString()),
          ],
        ));
  }

  Widget _buildActionButton(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/product/' +
                          productIndex.toString()) // using named route
                  .then((bool value) {
                if (value) {
                  // deleteProduct(index);
                }
              }),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          // TODO: Finish navigation when clicking on the heart icon
          onPressed: () => Navigator.pushNamed(
              context, '/product/' + productIndex.toString()),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products['image']),
          // SizedBox(height: 10.0,),
          _buildTitlePriceRow(),
          AddressTag('Union Square, San Francisco'),
          _buildActionButton(context),
        ],
      ),
    );
  }
}
