import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/models/favorite_item.dart';

class FavoritesCubit extends Cubit<List<FavoriteItem>> {
final Box<FavoriteItem> favBox; //hive box that contain all the modal/favorite items
 FavoritesCubit(this.favBox) : super(favBox.values.toList()); //the initial state is everything currently inside the hive box

 //load
 Future<void> loadFavorites() async {
 emit(favBox.values.toList());
 }

//toggle
Future<void> toggleFavorite(FavoriteItem item) async {
 if (favBox.containsKey(item.productId)) { //if it exists,
  await favBox.delete(item.productId); //remove it
  } else {
   await favBox.put(item.productId, item); //if it doesn't exist, put it
  }
   emit(favBox.values.toList());
 }

//clear
Future<void> clearFavorites() async {
 await favBox.clear();
 emit([]);
}

//is the product a favorite? check by searching by id inside the box
 bool isFavorite(int productId) => favBox.containsKey(productId);
}
