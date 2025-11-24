import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/product_repository.dart';

class CategoryCubit extends Cubit<List<String>> {
final ProductRepository repo;
CategoryCubit(this.repo) : super([]);

//fetch categories
Future<void> fetchCategories() async {
 try {
  final cats = await repo.getAllCategories();
 emit(cats);
   } catch (_) {
   emit([]); }
  }
}