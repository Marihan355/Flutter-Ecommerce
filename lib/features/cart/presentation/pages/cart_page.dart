import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../../data/models/cart_item.dart';
import '../../../../widgets/bottom_nav_bar.dart';

class CartPage extends StatefulWidget {
 const CartPage({super.key});

@override
 State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
@override
void initState() {
  super.initState();
  Future.microtask(() => context.read<CartCubit>().loadCart());
}

@override
Widget build(BuildContext context) {
return SafeArea(
  child: Scaffold(
   bottomNavigationBar: const BottomNavBar(currentIndex: 0),
 //appbar
 appBar: AppBar(
 title: const Text('Your Cart',
 style: TextStyle(
  fontFamily: 'PlayfairDisplay',
  fontWeight: FontWeight.bold,
   ),
  ),
 backgroundColor: Colors.purple,
 centerTitle: true,
   actions: [
     IconButton(
       icon: const Icon(Icons.delete_forever),
       onPressed: () {
         context.read<CartCubit>().clearCart();
       },
     ),
   ],
  ),
 body: BlocBuilder<CartCubit, CartState>(
builder: (context, state) {
  //if cart is empty
  if (state is CartInitial) {
  return const Center(child: CircularProgressIndicator());
 } else if (state is CartLoaded) {
  if (state.items.isEmpty) {
  return const Center(child: Text('Your cart is empty',style: TextStyle(
    fontFamily: 'PlayfairDisplay',
    color:Colors.black))
  );
 }

return Padding(
padding: EdgeInsets.all(16.w),
 child: Column(
  children: [
Expanded(
  child: ListView.builder(
  itemCount: state.items.length,
  itemBuilder: (_, i) {
  final item = state.items[i];
  return Card(
   color: Theme.of(context).cardColor,
    elevation: 2,
    margin: EdgeInsets.only(bottom: 12.h),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r)),
    child: ListTile(
     leading: ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.network(
      item.thumbnail,
      width: 60.w,
      height: 60.h,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
  const Icon(Icons.image),
  ),
   ),
  //title
 title: Text(
 item.title,
  style: const TextStyle(
   fontFamily: 'PlayfairDisplay',
   color:Colors.black,
   fontWeight: FontWeight.w600),
  ),
  //price
 subtitle: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
    Text('\$${item.price.toStringAsFixed(2)}',
    style: const TextStyle(
   color: Colors.purple,
    fontWeight: FontWeight.bold,
   ),
  ),
//counter
Row(
mainAxisSize: MainAxisSize.min,
 children: [
 IconButton(
  icon: const Icon(Icons.remove_circle_outline),
   onPressed: item.quantity > 1
   ? () => context.read<CartCubit>().decrement(item.productId)
   : null, //disabled when quantity= 1
   ),
 Text(
   '${item.quantity}',
   style: TextStyle(
    fontWeight: FontWeight.bold,
     fontSize: 16.sp,
      ),
     ),
 IconButton(
   icon: const Icon(Icons.add_circle_outline),
   onPressed: item.quantity < item.stock
    ? () => context.read<CartCubit>().increment(item.productId)
     : null, //disabled when quantity= stock
     ),
   ],
 ),
 ],
),
//delete
 trailing: IconButton(
  icon: Icon(Icons.delete_outline,
   color: Colors.red.shade400),
    onPressed: () => context
    .read<CartCubit>()
    .removeFromCart(item.productId),
   ),
    ),
   );
     },
    ),
  ),
//total
SizedBox(height: 12.h),
Container(
  padding: EdgeInsets.all(16.w),
  decoration: BoxDecoration(
    color: Colors.purple.shade50,
    borderRadius: BorderRadius.circular(12.r),
  ),
  // total row with BlocBuilder
  child: BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      final total = context.watch<CartCubit>().total;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'total'.tr(),
            style: const TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.purple,
            ),
          ),
        ],
      );
    },
  ),
),
 SizedBox(height: 12.h),
 ElevatedButton(
 onPressed: () => ScaffoldMessenger.of(context)
  .showSnackBar(const SnackBar(
  content:
  Text('order placed'))),
 style: ElevatedButton.styleFrom(
  backgroundColor: Colors.purple,
  padding: EdgeInsets.symmetric(
      vertical: 14.h, horizontal: 40.w),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.r),
  ),
 ),
 child: const Text('Checkout',
 style: TextStyle(
  fontFamily: 'PlayfairDisplay',
  fontWeight: FontWeight.w600,
  color: Colors.white),
   ),
   ),
  ],
 ),
);
}
 return const SizedBox.shrink();
 },
  ),
    ),
  );
 }
}