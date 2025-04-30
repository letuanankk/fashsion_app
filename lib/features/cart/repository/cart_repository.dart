import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/order/models/add_to_cart_req.dart';
import '../../../data/order/models/order_registration_req.dart';
import '../../../data/order/entities/order.dart';
import '../../../data/order/entities/product_ordered.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(firestore: FirebaseFirestore.instance),
);

class CartRepository {
  final FirebaseFirestore firestore;
  CartRepository({required this.firestore});

  Stream<List<ProductOrderedEntity>> getCartProductsStream(String userId) {
    try {
      return FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection('Orders')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return ProductOrderedEntity.fromMap(doc.data());
            }).toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch cart products. Please try again.');
    }
  }

  Future<void> addToCart(AddToCartReq addToCartReq) async {
    var user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .add(addToCartReq.toMap());
    } catch (e) {
      throw Exception('Failed to add to cart. Please try again.');
    }
  }

  Stream<List<ProductOrderedEntity>> getCartProducts() {
    var user = FirebaseAuth.instance.currentUser;
    try {
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return ProductOrderedEntity.fromMap(doc.data());
            }).toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch cart products. Please try again.');
    }
  }

  Future<void> removeCartProduct(String id) async {
    var user = FirebaseAuth.instance.currentUser;
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user!.uid)
              .collection('Cart')
              .get();

      for (var doc in returnedData.docs) {
        if (doc.data()['createdDate'] == id) {
          await doc.reference.delete();
          break;
        }
      }
    } catch (e) {
      throw Exception('Failed to remove product from cart. Please try again.');
    }
  }

  Future<void> orderRegistration(OrderRegistrationReq order) async {
    var user = FirebaseAuth.instance.currentUser;
    
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .add(order.toMap());

      for (var item in order.products) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .doc(item.id)
            .delete();
      }
    } catch (e) {
      throw Exception('Failed to register order. Please try again.');
    }
  }

  Stream<List<OrderEntity>> getOrders(){
    var user = FirebaseAuth.instance.currentUser;

    try {
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return OrderEntity.fromMap(doc.data());
            }).toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch orders. Please try again.');
    }
  }
}
