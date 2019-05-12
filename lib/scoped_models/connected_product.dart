import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

mixin ConnectedProducts on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  bool _isLoading = false;

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://cdn.newsapi.com.au/image/v1/551af2930c81cf6c4aaa1c5d9f1c075f',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    // _isLoading parameter is for the spinner, if it is true then display the spinner.
    _isLoading = true;
    notifyListeners();

    // Convert the Map productData to Json
    // post the product and save the returned unique id
    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    try {
      final Response response = await dio.post(
          'https://flutter-products-82ea3.firebaseio.com/product.json',
          data: productData);
      if (response.statusCode != 200 && response.statusCode != 201) {
        // return code indicating failed
        print("statuscode != 200!");
        _isLoading = false;
        notifyListeners();
        return false;
      }
      print(response.data);
      final Map<String, dynamic> responseData = response.data;
      print(responseData);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      print("We got an error here");
      print(error.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
    // After the POST, we will receive a unique ID, which is generated by Firebase, and also a response.
    // This unique ID is the one that will be used for editing, deleting the item we added under ./products node
  }
}

mixin ProductsModel on ConnectedProducts {
  bool _showFavorites = false;

  // remove the viewed product
  Future<bool> deleteProduct() async {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();

    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    try {
      final Response response = await dio.delete(
          'https://flutter-products-82ea3.firebaseio.com/product/$deletedProductId.json');
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    try {
      final Response response = await dio
          .get('https://flutter-products-82ea3.firebaseio.com/product.json');
      // print(response.data);
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = response.data;
      if (productListData == null) {
        _isLoading = false;
        print("*************The response is empty*************");
        notifyListeners();
        return false;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            image: productData['image'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    // print(json.decode(response.data));
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    // Setting up the proxy configuration
    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    // update the product which is indexed by the unique id
    try {
      final Map<String, dynamic> updateData = {
        'title': title,
        'description': description,
        'image':
            'https://cdn.newsapi.com.au/image/v1/551af2930c81cf6c4aaa1c5d9f1c075f',
        'price': price,
        'userEmail': selectedProduct.userEmail,
        'userId': selectedProduct.userId
      };

      final Response response = await dio.put(
          'https://flutter-products-82ea3.firebaseio.com/product/${selectedProduct.id}.json',
          data: json.encode(updateData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Product newProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _products[selectedProductIndex] = newProduct;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  // editing the favorite status then overwrite previous one
  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updateProduct;
    notifyListeners(); // update all scoped model listeners so that they re-render their builder methods
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  // return a brand new list to avoid direct add on original list
  // such as _products.add(Product());
  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
      // return the elements which isFavorite property is true
    }
    return List.from(_products);
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }
}

mixin UserModel on ConnectedProducts {
  Future<Map<String, dynamic>> login(String email, String password) async {
    // _authenticatedUser =
    // new User(id: 'c13063716100', email: email, password: password);
    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    var encodedAuthData = json.encode(authData);
    print(encodedAuthData);
    final Response response = await dio.post(
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyAQVjpNexpmWltlIM9y5vSZ04E1R2d7pRY",
        data: encodedAuthData,
        options: Options(headers: {'Content-Type': 'application/json'}));
    final Map<String, dynamic> responseData = response.data;
    print(responseData);
    String message = 'Something went wrong';
    bool hasError = true;

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD'){
      message = 'Invalid password';
    }
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    // proxy setup
    var dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 127.0.0.1:1087";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    var encodedAuthData = json.encode(authData);
    print(encodedAuthData);

    final Response response = await dio.post(
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyAQVjpNexpmWltlIM9y5vSZ04E1R2d7pRY",
        data: encodedAuthData,
        options: Options(headers: {'Content-Type': 'application/json'}));

    final Map<String, dynamic> responseData = response.data;
    String message = 'Something went wrong';
    bool hasError = true;

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email already exists';
    }
    return {'success': !hasError, 'message': message};
  }
}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading {
    return _isLoading;
  }
}
