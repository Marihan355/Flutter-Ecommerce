import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../cart/data/models/cart_item.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../favorite/data/models/favorite_item.dart';
import '../../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../../data/models/product_model.dart';
import '../product_detail_page.dart';

class ProductListItem extends StatelessWidget {
  final ProductModel product;
  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
      builder: (context, favorites) {
        final isFav = favorites.any((f) => f.productId == product.id);

        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
          ),
          borderRadius: BorderRadius.circular(12),
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail ?? '',
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey[200]),
                      errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10,color: Colors.black,),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (product.description ?? '')
                              .split(' ')
                              .take(6)
                              .join(' ')
                              + ((product.description?.split(' ').length ?? 0) > 10 ? '...' : ''),
                          style: TextStyle(color: Colors.grey[600], fontSize: 9),
                        ),
                        const SizedBox(height: 6),
                       // Row(
                        //  children: [
                            Text(
                              '\$${product.price?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                     // ],
                   // ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.purpleAccent : Colors.grey,
                      size: 22,
                    ),
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(
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
                          content: Text(isFav ? 'Removed from favorites' : 'Added to favorites'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}