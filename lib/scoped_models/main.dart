import 'package:scoped_model/scoped_model.dart';
import 'connected_product.dart';
// merge products and user model into one
class MainModel extends Model with ConnectedProducts, UserModel, ProductsModel, UtilityModel{

}