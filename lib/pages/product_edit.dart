import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_models/main.dart';
import '../widgets/ensure-visible.dart';
import 'package:scoped_model/scoped_model.dart';

// Note that these two "pages" are not actually pages, because it exists as widget embedded in product_admin page.
// Also, the product_admin page does not override/replace the original page. Therefore in this class, it returns a body widget
class ProductEditPage extends StatefulWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Product Title'),
          validator: (String value) {
            // if return something, validator failed
            if (value.isEmpty || value.length < 5) {
              return 'Title is required and should be 5 characters long';
            }
          },
          initialValue: product == null ? '' : product.title,
          onSaved: (String value) {
            _formData['title'] = value;
          },
        ),
        focusNode: widget._titleFocusNode);
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: widget._descriptionFocusNode,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Product Description'),
        autofocus: false,
        maxLines: 4,
        initialValue: product == null ? '' : product.description,
        validator: (String value) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required and should be 10 characters long';
          }
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Product Price'),
          keyboardType: TextInputType.number, // limit the input into number
          autofocus: false,
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Price is required and should be a number';
            }
          },
          initialValue: product == null ? '' : product.price.toString(),
          onSaved: (String value) {
            _formData['price'] = double.parse(value);
          },
        ),
        focusNode: widget._priceFocusNode);
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct,
              model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // close the
      },
      child: Container(
          width: targetWidth,
          margin: EdgeInsets.all(10.0),
          child: Form(
            key:
                _formKey, // identifier that allows us to access the form object from other parts of the app
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
                SizedBox(
                  height: 10.0,
                ),
                _buildSubmitButton(),
                // save the product
              ],
            ),
          )),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    // [] means optional argument
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // when the key currentState becomes save, all onSaved() method in TextFormField widget will be executed
    if (selectedProductIndex == null) {
      addProduct(_formData['title'], _formData['description'],
          _formData['image'], _formData['price']);
    } else {
      updateProduct(_formData['title'], _formData['description'],
          _formData['image'], _formData['price']);
    }
    Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Widget pageContent =
              _buildPageContent(context, model.selectedProduct);
          return model.selectedProductIndex == null
              ? pageContent
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Edit Product'),
                  ),
                  body: pageContent,
                );
        },
      ),
    );
  }
}
