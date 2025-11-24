import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class CartItem extends HiveObject {
  @HiveField(0) final int productId; //cannot be changed after creation
  @HiveField(1) final String title;
  @HiveField(2) final double price;
  @HiveField(3) int quantity;
  @HiveField(4) final String thumbnail;
  @HiveField(5) final int stock;

CartItem({ //constructor
 required this.productId,
 required this.title,
 required this.price,
 required this.quantity,
 required this.thumbnail,
  required this.stock,
});
}

class CartItemAdapter extends TypeAdapter<CartItem> { //Hive cannot automatically save custom classes, so i need an adabtor
@override final int typeId = 2;  //must match the HiveType in CartItem

@override CartItem read(BinaryReader reader) {
 final n = reader.readByte();
 final f = <int,dynamic>{ for (int i=0;i<n;i++) reader.readByte(): reader.read() }; //read() converts binary back to Cartittem object. it reads all the feilds in the order they were written using their key 0,1,2,3
 return CartItem(
  productId: f[0] as int,
  title: f[1] as String,
  price: f[2] as double,
  quantity: f[3] as int,
  thumbnail: f[4] as String,
   stock: f[5] as int,

  );
}

@override void write(BinaryWriter writer, CartItem obj) { //converts Cartittem into binary so Hive can save them, store feild(n) and it's value
  writer
  ..writeByte(6) //number of feilds
  ..writeByte(0)..write(obj.productId)
  ..writeByte(1)..write(obj.title)
  ..writeByte(2)..write(obj.price)
  ..writeByte(3)..write(obj.quantity)
  ..writeByte(4)..write(obj.thumbnail)
  ..writeByte(5)..write(obj.stock);
 }
}
