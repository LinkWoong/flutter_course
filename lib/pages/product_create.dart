import 'package:flutter/material.dart';

// Note that these two "pages" are not actually pages, because it exists as widget embedded in product_admin page.
// Also, the product_admin page does not override/replace the original page. Therefore in this class, it returns a body widget
class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: false,
      maxLines: 1,
      onChanged: (String value) {
        setState(() {
          titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Description'),
      autofocus: false,
      maxLines: 4,
      onChanged: (String value) {
        setState(() {
          descriptionValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number, // limit the input into number
      autofocus: false,
      onChanged: (String value) {
        setState(() {
          priceValue = double.parse(value);
        });
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': titleValue,
      'description': descriptionValue,
      'price': priceValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding),
        children: <Widget>[
          // title
          _buildTitleTextField(),
          // Description
          _buildDescriptionTextField(),
          // Price
          _buildPriceTextField(),
          // create some space
          SizedBox(
            height: 10.0,
          ),
          // save the product
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: _submitForm,
          )
        ],
      ),
    );
  }
}
