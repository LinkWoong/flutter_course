import 'package:flutter/material.dart';

// Note that these two "pages" are not actually pages, because it exists as widget embedded in product_admin page.
// Also, the product_admin page does not override/replace the original page. Therefore in this class, it returns a body widget
class ProductCreatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
  }
}