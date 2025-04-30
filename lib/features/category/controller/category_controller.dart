import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/category/entity/category.dart';
import '../repository/category_repository.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository, ref: ref);
});

class CategoryController {
  final CategoryRepository categoryRepository;
  final ProviderRef ref;
  CategoryController({required this.categoryRepository, required this.ref});


  Future<List<CategoryEntity>> getCategories() async {
    return await categoryRepository.getCategories();
  }
}