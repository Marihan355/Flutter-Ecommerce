import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepository {
final ProductRemoteDataSource remote; //the ProductRemoteDataSource
ProductRepository(this.remote);

//get products, cleaner
Future<List<ProductModel>> getAllProducts() async { 
 final list = await remote.getAllProducts();
 return list;
 }

//get categories
Future<List<String>> getAllCategories() => remote.getAllCategories();
}
