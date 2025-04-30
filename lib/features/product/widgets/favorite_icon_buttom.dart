import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/product/entities/product.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier() : super(false);

  Future<void> checkIfFavorite(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      var products =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .collection('Favorites')
              .where('productId', isEqualTo: productId)
              .get();

      state = products.docs.isNotEmpty;
    } catch (e) {
      state = false; // Default to not favorite if an error occurs
    }
  }

  Future<void> toggleFavorite(ProductEntity product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      var favoritesRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection('Favorites');

      var products =
          await favoritesRef
              .where('productId', isEqualTo: product.productId)
              .get();

      if (products.docs.isNotEmpty) {
        // Remove from favorites
        await products.docs.first.reference.delete();
        state = false;
      } else {
        // Add to favorites
        await favoritesRef.add(product.toMap());
        state = true;
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite status. Please try again.');
    }
  }
}

final favoriteProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, String>(
      (ref, productId) => FavoriteNotifier()..checkIfFavorite(productId),
    );
