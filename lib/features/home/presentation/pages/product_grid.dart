import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'widgets/product_card.dart';
import 'widgets/product_list_item.dart';
import 'product_detail_page.dart';

class ProductGrid extends StatefulWidget {
  final String? category;
  const ProductGrid({super.key, this.category});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(isGrid ? Icons.grid_view : Icons.view_list),
                color:Colors.black,
                onPressed: () => setState(() => isGrid = !isGrid),
              ),
              Text('View: ${isGrid ? 'Grid' : 'List'}', style: const TextStyle(fontWeight: FontWeight.w500, color:Colors.black )),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh),
                color:Colors.black,
                onPressed: () => context.read<ProductCubit>().fetchProducts(),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) return const Center(child: CircularProgressIndicator());
              if (state is ProductLoaded) {
                final items = widget.category == null
                    ? state.products
                    : state.products
                    .where((p) => p.category?.toLowerCase() == widget.category?.toLowerCase())
                    .toList();

                if (items.isEmpty) return const Center(child: Text('No products found'));

                return isGrid ? _buildGrid(items) : _buildList(items);
              }
              if (state is ProductError) return Center(child: Text(state.message));
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<ProductModel> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => ProductCard(product: items[i]),
    );
  }

  Widget _buildList(List<ProductModel> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (_, i) => ProductListItem(product: items[i]),
    );
  }
}