import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/models/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

 final Box<CartItem> cartBox; //the hive box that carries all cart items

 CartCubit(this.cartBox) : super(CartInitial()) { //pass the cartBox to cubit and give it an initial state point
  loadCart();
}

// Load cart
Future<void> loadCart() async {
  await Future.delayed(const Duration(seconds: 1)).then((e){ // just to simulate a spinner //Future<void> loadCart() async {
  var items = cartBox.values.toList();  //the values are the cartitems inside the cartBox, and convert it to a list
  emit(CartLoaded(items)); 
 });
  }

//update quantity(when add to cart button of same product is clicked more than once)
Future<void> updateQuantity(int productId, int quantity) async {
 if (!cartBox.containsKey(productId)) return;      //if the product id, don't exist already in the box, return. because this is not updatte quantity then, it's add
  final item = cartBox.get(productId)!;
 if (quantity > item.stock) {    //quantity between 1 and stock
   item.quantity = item.stock;
 } else if (quantity < 1) {
   item.quantity = 1;
 } else {
   item.quantity = quantity;
 }
 await item.save();
 emit(CartLoaded(cartBox.values.toList()));
}

  // add if didn't exist / update quantity if in cart already
Future<void> addToCart(CartItem item) async {
  emit(CartInitial());
  if (cartBox.containsKey(item.productId)) {
    // update existing
    final existing = cartBox.get(item.productId)!;
    if (existing.quantity < existing.stock) {
      existing.quantity++;
      await existing.save();
    }
  }else {
  // add
  await cartBox.put(item.productId, item);
  }
  // reload
   final items = cartBox.values.toList();
    emit(CartLoaded(items));
 }

//remove one item
Future<void> removeFromCart(int productId) async {
   await cartBox.delete(productId);
    emit(CartLoaded(cartBox.values.toList()));
 }

  //Clear cart
Future<void> clearCart() async {
 await cartBox.clear();
  emit(CartLoaded([]));
}
//the counter
//increment
  Future<void> increment(int productId) async {
    if (!cartBox.containsKey(productId)) return; //defensive programing, in case ui sends the wrong product id
    final item = cartBox.get(productId)!;
    // if quantity == stock
    if (item.quantity >= item.stock) {
      emit(CartLoaded(cartBox.values.toList()));
      return;
    }
    item.quantity++;
    await item.save();
    emit(CartLoaded(cartBox.values.toList()));
  }

//decrement
Future<void> decrement(int productId) async {
  if (!cartBox.containsKey(productId)) return;
  final item = cartBox.get(productId)!;
  if (item.quantity > 1) {
   item.quantity--;
    await item.save();
  }
   emit(CartLoaded(cartBox.values.toList()));
 }

//refresh
void refresh() {
  emit(CartLoaded(cartBox.values.toList()));
}

//total
  double get total {
   return cartBox.values.fold( // //fold is a list function in dart. it loops through the list and build result aas everyone adds one by one
    0, (sum, item) => sum + (item.price * item.quantity), //0.0 is the intial vale that everything is added to
   );
  }
}