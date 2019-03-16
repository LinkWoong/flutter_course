import 'package:flutter_course/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model{
  // dynamic means mixed type
  List<Product> _products = [];
  int _selectedProductIndex;

  // lifting the state up
  void addProduct(Product product) {
    // receive an argument
    _products.add(product);
    _selectedProductIndex = null;
  }

  // remove the viewed product
  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product){
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void selectProduct(int index){
    _selectedProductIndex = index;
  }

  // return a brand new list
  List<Product> get products{
    return List.from(_products);
  }

  int get selectProductIndex{
    return selectProductIndex;
  }

  Product get selectedProduct{
    if(_selectedProductIndex == null){
      return null;
    }
    return _products[selectProductIndex];
  }

}