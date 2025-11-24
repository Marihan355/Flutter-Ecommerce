import '../../../../core/data/datasources/api_service.dart'; //one responsible for making http requests
import '../models/product_model.dart';

class ProductRemoteDataSource {
final ApiService api;      //use ApiService bacause this calss must call API
ProductRemoteDataSource(this.api);

//get products
Future<List<ProductModel>> getAllProducts() async {
 final resp = await api.get('products'); //get the products that's my response
 final data = resp.data;            //res
 if (data == null) return [];      //if the list is empty, give empty arr
 final list = (data['products'] as List).cast<Map<String,dynamic>>(); //string key, dynamic values
 return list.map((e) =>
 ProductModel.fromJson(e)).toList();  //map: loop through and turn from json to list
}

//get categories
Future<List<String>> getAllCategories() async {
 final resp = await api.get('products/categories');
 if (resp.data == null) return [];
 return (resp.data as List)
 .map((e) => e['name'].toString()) //loop through each category, take "name" feild, convert to string, retuurn as list
 .toList();
 }
}