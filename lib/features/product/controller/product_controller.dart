import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/product/entities/product.dart';
import '../repository/product_repository.dart';

final productControllerProvider = Provider((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductController(productRepository: productRepository, ref: ref);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedProductsProvider =
    FutureProvider.autoDispose<List<ProductEntity>>((ref) {
      final query = ref.watch(searchQueryProvider);
      return ref.watch(productControllerProvider).getProductsByTitle(query);
    });

class ProductController {
  final ProductRepository productRepository;

  final ProviderRef ref;
  ProductController({required this.productRepository, required this.ref});

  Future<List<ProductEntity>> getTopSelling() async {
    try {
      return await productRepository.getTopSelling();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductEntity>> getNewIn() async {
    try {
      return await productRepository.getNewIn();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductEntity>> getProductsByCategoryId(String categoryId) async {
    return await productRepository.getProductsByCategoryId(categoryId);
  }

  Future<List<ProductEntity>> getProductsByTitle(String title) async {
    try {
      return await productRepository.getProductsByTitle(title);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      await productRepository.addOrRemoveFavoriteProduct(product);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isFavorite(String productId) async {
    try {
      return await productRepository.isFavorite(productId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductEntity>> getFavoritesProducts() {
    return productRepository.getFavoritesProducts();
  }
}
