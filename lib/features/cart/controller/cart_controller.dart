import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/order/models/add_to_cart_req.dart';
import '../../../data/order/models/order_registration_req.dart';
import '../../../data/order/entities/order.dart';
import '../../../data/order/entities/product_ordered.dart';
import '../repository/cart_repository.dart';

final cartControllerProvider = Provider((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartController(cartRepository: cartRepository, ref: ref);
});

class CartController {
  final CartRepository cartRepository;
  final ProviderRef ref;
  CartController({required this.cartRepository, required this.ref});

  Stream<List<ProductOrderedEntity>> getCartProductsStream(String userId) {
    return cartRepository.getCartProductsStream(userId);
  }

  Future<void> addToCart(AddToCartReq addToCartReq) async {
    try {
      await cartRepository.addToCart(addToCartReq);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductOrderedEntity>> getCartProducts() {
    return cartRepository.getCartProducts();
  }

  Future<void> removeFromCart(String cartId) async {
    await cartRepository.removeCartProduct(cartId);
  }

  Future<void> orderRegistration(OrderRegistrationReq order) async {
    try {
      await cartRepository.orderRegistration(order);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderEntity>> getOrders() {
    return cartRepository.getOrders();
  }
}
