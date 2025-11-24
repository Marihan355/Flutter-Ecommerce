import '../../data/models/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {

//list of items in the cart
 List<CartItem> items;  //CartItem from models/cartItem with everything it carries.

 CartLoaded(this.items); //so items is an arry of cartItems//items carrying everthing in tha cart

}
