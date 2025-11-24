import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cart/data/models/cart_item.dart';
import '../../data/models/favorite_item.dart';
import '../cubit/favorite_cubit.dart';
import '../../../../widgets/bottom_nav_bar.dart';
import '../../../home/presentation/pages/product_page_wrapper.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

class FavoritesPage extends StatefulWidget {
const FavoritesPage({super.key});

@override
State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
@override
void initState() {
 super.initState();
// load favorites
 context.read<FavoritesCubit>().loadFavorites();
}

@override
Widget build(BuildContext context) {
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;

return SafeArea(
 child: Scaffold(
  bottomNavigationBar: const BottomNavBar(currentIndex: 2),
 //appBar
 appBar: AppBar(
  title: const Text('Favorites',
  style: TextStyle(fontFamily: 'PlayfairDisplay'),
 ),
  centerTitle: true,
  backgroundColor: Colors.purple,
//clear btn
 actions: [
 IconButton(
  icon: const Icon(Icons.delete_forever),
  onPressed: () => context.read<FavoritesCubit>().clearFavorites(),
  tooltip: 'Clear All',
     ),
   ],
 ),
 body: BlocBuilder<FavoritesCubit, List<FavoriteItem>>(  
  builder: (context, list) {
 //if list empty
   if (list.isEmpty) {
   return Center(
    child: Text(
   'No favorites yet',
    style: TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 16.sp,
    color: Colors.grey,
    ),
  ),
 );
}

return Padding(
 padding: EdgeInsets.symmetric(
  horizontal: width * 0.04, vertical: height * 0.01),
  child: ListView.separated(
    itemCount: list.length,
    separatorBuilder: (_, __) => SizedBox(height: height * 0.01),
    itemBuilder: (_, i) {
 final f = list[i];
return Container(
 height: height * 0.12,
 decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(12.r),
  color: Colors.purple.shade50,
  boxShadow: [
   BoxShadow(
  color: Colors.black12,
  blurRadius: 4.r,
  offset: const Offset(0, 2),
   ),
  ],
 ),
child: Row(
children: [
//clipRRect clips(cut) its child widget for rounded corners
 ClipRRect(
  borderRadius: const BorderRadius.horizontal(
  left: Radius.circular(12)),
  child: Image.network(
   f.thumbnail,
    width: width * 0.25,
    height: double.infinity, //fill all the available space
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) =>
    const Icon(Icons.image, size: 40),
  ),
 ),
//title,price
SizedBox(width: width * 0.04),
Expanded(
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
   Text(
   f.title,
   maxLines: 2,
   overflow: TextOverflow.ellipsis,
    style: TextStyle(
    fontFamily: 'PlayfairDisplay',
     fontSize: 10.sp,
      color:Colors.black ,
      fontWeight: FontWeight.w600,
    ),
  ),
 //price
 SizedBox(height: 4.h),
 Text(
  '\$${f.price.toStringAsFixed(2)}',
   style: TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: Colors.purple,
    ),
  ),
 ],
 ),
),
 //add to cart and delete from cart
 Row(
 mainAxisSize: MainAxisSize.min,
 children: [
 IconButton(
    icon: Icon(
    Icons.add_shopping_cart,
    color: Colors.green,
    size: width * 0.06,
    ),
 onPressed: () {// add to cart
  context.read<CartCubit>().addToCart(
  CartItem(
   productId: f.productId,
    title: f.title,
   price: f.price,
    quantity: 1,
    thumbnail: f.thumbnail,
   stock: f.stock,
    ),
  );
//remove from favorites
 context.read<FavoritesCubit>().toggleFavorite(f);
    },
  ),
 IconButton(
   icon: Icon(
    Icons.delete_outline,
    color: Colors.red,
    size: width * 0.06,
    ),
  onPressed: () => context.read<FavoritesCubit>().toggleFavorite(f),
  ),
        ],
      ),
    ],
     ),
     );
    },
     ),
    );
   },
  ),
   ),
  );
  }
 }