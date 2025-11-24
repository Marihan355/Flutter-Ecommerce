import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/product_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
final ProductRepository repo;
ProductCubit(this.repo) : super(ProductInitial());  //pass repo and it's initial point(state)

//fetch products
Future<void> fetchProducts() async {
 emit(ProductLoading());
 try {
  final list = await repo.getAllProducts();
 emit(ProductLoaded(list));
 } catch (e) {
  emit(ProductError(e.toString()));
  }
 }
}