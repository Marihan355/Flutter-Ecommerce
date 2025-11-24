import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/data/models/cart_item.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../favorite/data/models/favorite_item.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../data/models/product_model.dart';
import '../../../../core/utils/responsiveness.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final w = screenWidth(context);
    final h = screenHeight(context);

    final favCubit = context.read<FavoritesCubit>();
    final isFav = favCubit.state.any((f) => f.productId == product.id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: w * 0.035), 
          ),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                favCubit.toggleFavorite(
                  FavoriteItem(
                    productId: product.id ?? 0,
                    title: product.title ?? '',
                    thumbnail: product.thumbnail ?? '',
                    price: product.price ?? 0.0,
                    rating: product.rating ?? 0.0,
                    stock: product.stock ?? 0,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFav
                        ? 'Removed from favorites'
                        : 'Added to favorites'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(w * 0.04), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.35, 
                child: PageView.builder(
                  itemCount: product.images.length,
                  itemBuilder: (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(w * 0.04), 
                    child: CachedNetworkImage(
                      imageUrl: product.images[i],
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: Colors.grey[200],
                        child:
                            const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                product.title ?? '',
                style: TextStyle(
                  fontSize: w * 0.04, 
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: h * 0.01),
              Row(
                children: [
                  Text(
                    '\$${product.price?.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: w * 0.045, 
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.star, color: Colors.purpleAccent, size: w * 0.04),
                  SizedBox(width: w * 0.01),
                  Text(
                    '${product.rating ?? 0.0}',
                    style: TextStyle(
                      fontSize: w * 0.035, 
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.015),
              Text(
                (product.stock ?? 0) > 0 ? 'In stock' : 'Out of stock',
                style: TextStyle(
                  fontSize: w * 0.035,
                  color: (product.stock ?? 0) > 0 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                product.description ?? 'No description available.',
                style: TextStyle(
                  fontSize: w * 0.04, 
                  color: Colors.black,
                ),
              ),
              SizedBox(height: h * 0.03),
              SizedBox(
                width: double.infinity,
                height: h * 0.06, 
                child: ElevatedButton.icon(
                  onPressed: (product.stock ?? 0) > 0
                      ? () {
                          context.read<CartCubit>().addToCart(
                                CartItem(
                                  productId: product.id ?? 0,
                                  title: product.title ?? '',
                                  price: product.price ?? 0.0,
                                  quantity: 1,
                                  thumbnail: product.thumbnail ?? '',
                                  stock: product.stock ?? 0,
                                ),
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      : null, // Disabled when stock = 0
                  icon: (product.stock ?? 0) > 0
                      ? Icon(Icons.add_shopping_cart,
                          color: Colors.white, size: w * 0.05)
                      : const SizedBox(),
                  label: Text(
                    (product.stock ?? 0) > 0
                        ? 'add_to_cart'.tr()
                        : 'coming_soon'.tr(),
                    style: TextStyle(
                      fontSize: w * 0.045, 
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (product.stock ?? 0) > 0
                        ? Colors.purple
                        : Colors.pink, // coming soon
                    disabledBackgroundColor: Colors.pink, // when disabled
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}