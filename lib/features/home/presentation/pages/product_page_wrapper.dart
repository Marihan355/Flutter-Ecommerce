import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/data/datasources/api_service.dart';
import '../../../cart/data/models/cart_item.dart';
import '../../../favorite/data/models/favorite_item.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../presentation/cubit/category_cubit.dart';
import '../../presentation/cubit/product_cubit.dart';
import 'products_page.dart';

class ProductsPageWrapper extends StatelessWidget {
  const ProductsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final favBox = Hive.box<FavoriteItem>('favorites');
    final cartBox = Hive.box<CartItem>('cart');
    final api = ApiService();
    final remote = ProductRemoteDataSource(api);
    final repo = ProductRepository(remote);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(repo)..fetchProducts()),
        BlocProvider(create: (_) => CategoryCubit(repo)..fetchCategories()),
        BlocProvider(create: (_) => CartCubit(cartBox)),
        BlocProvider(create: (_) => FavoritesCubit(favBox)),
      ],
      child: const SafeArea(
        child: ProductsPage(),
      ),
    );
  }
}