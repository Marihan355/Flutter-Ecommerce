import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class FavoriteItem extends HiveObject {
  @HiveField(0) final int productId;
  @HiveField(1) final String title;
  @HiveField(2) final String thumbnail;
  @HiveField(3) final double price;
  @HiveField(4) final double rating;
  @HiveField(5) final int stock;

FavoriteItem({
  required this.productId,
  required this.title,
  required this.thumbnail,
  required this.price,
  required this.rating,
  required this.stock,});
}

class FavoriteItemAdapter extends TypeAdapter<FavoriteItem> { //Hive cannot automatically save custom classes, so i need an adabtor
 @override final int typeId = 3;

 @override FavoriteItem read(BinaryReader reader) {  ////read() converts binary back to Favitem object. it reads all the feilds in the order they were written using their key 0,1,2,3
final n = reader.readByte();
final f = <int,dynamic>{ for (int i=0;i<n;i++) reader.readByte(): reader.read() };
return FavoriteItem(
  productId: f[0] as int,
   title: f[1] as String,
  thumbnail: f[2] as String,
  price: f[3] as double,
   rating: f[4] as double,
  stock: f[5] as int,
   );
 }

@override void write(BinaryWriter writer, FavoriteItem obj) {  //converts Favittem into binary so Hive can save them, store feild(n) and it's value
 writer
  ..writeByte(6)
  ..writeByte(0)..write(obj.productId)
  ..writeByte(1)..write(obj.title)
  ..writeByte(2)..write(obj.thumbnail)
  ..writeByte(3)..write(obj.price)
  ..writeByte(4)..write(obj.rating)
  ..writeByte(5)..write(obj.stock);
 }
}
