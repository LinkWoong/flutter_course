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
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null
  };


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      validator: (String value){ // if return something, validator failed
        if(value.isEmpty || value.length < 5){
          return 'Title is required and should be 5 characters long';
        }
      },
      onSaved: (String value){
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      autofocus: false,
      maxLines: 4,
      validator: (String value){
        if(value.isEmpty || value.length < 10){
          return 'Description is required and should be 10 characters long';
        }
      },
      onSaved: (String value){
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number, // limit the input into number
      autofocus: false,
      validator: (String value){
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)){
          return 'Price is required and should be a number';
        }
      },
      onSaved: (String value){
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    // when the key currentState becomes save, all onSaved() method in TextFormField widget will be executed
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode()); // close the
      },
      child: Container(
          width: targetWidth,
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey, // identifier that allows us to access the form object from other parts of the app
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding),
              children: <Widget>[
                _buildTitleTextField(),
                _buildDescriptionTextField(),
                _buildPriceTextField(),
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
          )),
    );
  }
}
