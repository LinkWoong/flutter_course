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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          // title
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            autofocus: false,
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),

          // Description
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            autofocus: false,
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
          ),

          // Price
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number, // limit the input into number
            autofocus: false,
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
          ),
          // create some space
          SizedBox(
            height: 10.0,
          ),
          // save the product
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: () {
              final Map<String, dynamic> product = {
                'title': titleValue,
                'description': descriptionValue,
                'price': priceValue,
                'image': 'assets/food.jpg'
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
    /*
    return Center(
      child: RaisedButton(
        child: Text('Save'),
        onPressed: (){
          showModalBottomSheet(
            // slides up a sheet from the bottom of the page into which you can put additional information
            // or actions, your own interface where the user can do something.
              context: context,
              builder: (BuildContext context){
                return Center(
                  child: Text('This is a modal'),
                );
              });
        },
      )
    );
    */
  }
}
