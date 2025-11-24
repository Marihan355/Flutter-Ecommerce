import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/favorite/presentation/pages/favorites_page.dart';
import '../features/home/presentation/pages/product_page_wrapper.dart';

class BottomNavBar extends StatelessWidget {
const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);
final int currentIndex;

@override
Widget build(BuildContext context) {
final colorScheme = Theme.of(context).colorScheme;

return ConvexAppBar(
  backgroundColor: colorScheme.primary,
 color: colorScheme.onPrimary,
  activeColor: colorScheme.onPrimary,
  style: TabStyle.fixedCircle,
 height: 60,
  items: [
  TabItem(icon: Icons.shopping_cart, title: 'cart'.tr()),
  TabItem(icon: Icons.home, title: 'home'.tr()),
  TabItem(icon: Icons.favorite, title: 'favorite'.tr()),
  ],
//switch betweeen cart and home and favorite
onTap: (index) {
switch (index) {
  case 0:
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const CartPage()),
    );
    break;
  case 1:
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const ProductsPageWrapper()),
    );
    break;
  case 2:
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const FavoritesPage()),
    );
  break;
  }
 },
 );
 }
}