import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../cart/data/models/cart_item.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../favorite/data/models/favorite_item.dart';
import '../../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../../data/models/product_model.dart';
import '../product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
      builder: (context, favorites) {
        final isFav = favorites.any((f) => f.productId == product.id);

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            ),
          ),
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'product_${product.id}',
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: product.thumbnail ?? "",
                          imageBuilder: (context, image) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      Positioned(
                        right: 6.w,
                        top: 6.h,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () {
                            context.read<FavoritesCubit>().toggleFavorite(
                              FavoriteItem(
                                productId: product.id ?? 1,
                                title: product.title ?? "",
                                thumbnail: product.thumbnail ?? "",
                                price: product.price ?? 0.0,
                                rating: product.rating ?? 0.0,
                                stock: product.stock ?? 0,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFav ? 'Removed from favorites' : 'Added to favorites',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.85),
                            radius: 18.r,
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.purpleAccent : Colors.grey,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    product.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:Colors.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child:
                      Text(
                        '\$${product.price?.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 9.sp,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child:
                      Text(
                        (product.stock ?? 0) > 0 ? 'In stock' : 'Out of stock',
                        style: TextStyle(
                          color: (product.stock ?? 0) > 0 ? Colors.purpleAccent : Colors.red,
                          fontSize: 9.sp,
                        ),
                      ),

                 ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: ElevatedButton.icon(
                    onPressed: (product.stock ?? 0) > 0
                        ? () {
                      context.read<CartCubit>().addToCart(
                        CartItem(
                          productId: product.id ?? 1,
                          title: product.title ?? "",
                          price: product.price ?? 0.0,
                          quantity: 1,
                          thumbnail: product.thumbnail ?? "",
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
                        : null, // disabled if stock is 0

                    label: Text(
                      (product.stock ?? 0) > 0 ? 'add_to_cart'.tr() : 'coming_soon'.tr(),
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 36.h),
                      backgroundColor: (product.stock ?? 0) > 0 ? const Color(0xFFBA68C8): Colors.purple[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}