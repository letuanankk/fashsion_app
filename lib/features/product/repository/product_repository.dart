import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/data/product/models/product.dart';
import 'package:my_shop_app/data/product/entities/product.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    storage: FirebaseStorage.instance,
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ProductRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  ProductRepository({
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  Future<List<ProductEntity>> getTopSelling() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection('Products')
              .where('salesNumber', isGreaterThanOrEqualTo: 20)
              .get();
      var products =
          returnedData.docs.map((e) {
            return ProductModel.fromMap(e.data()).toEntity();
          }).toList();
      return products;
    } catch (e) {
      throw Exception(
        'Failed to fetch top-selling products. Please try again.',
      );
    }
  }

  Future<List<ProductEntity>> getNewIn() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection('Products')
              .where(
                'createdDate',
                isGreaterThanOrEqualTo: DateTime(2024, 07, 25),
              )
              .get();
      var products =
          returnedData.docs.map((e) {
            return ProductModel.fromMap(e.data()).toEntity();
          }).toList();
      return products;
    } catch (e) {
      throw Exception('Failed to fetch new products. Please try again.');
    }
  }

  Future<List<ProductEntity>> getProductsByCategoryId(String categoryId) async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection('Products')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      var products =
          returnedData.docs.map((e) {
            return ProductModel.fromMap(e.data()).toEntity();
          }).toList();
      return products;
    } catch (e) {
      throw Exception(
        'Failed to fetch products by category. Please try again.',
      );
    }
  }

  Future<List<ProductEntity>> getProductsByTitle(String title) async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection('Products')
              .where('title', isGreaterThanOrEqualTo: title)
              .where('title', isLessThan: '${title}z')
              .get();

      var products =
          returnedData.docs.map((e) {
            return ProductModel.fromMap(e.data()).toEntity();
          }).toList();

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products by title. Please try again.');
    }
  }

  Future<bool> addOrRemoveFavoriteProduct(ProductEntity product) async {
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
              .where('productId', isEqualTo: product.productId)
              .get();

      if (products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return false; // Product removed from favorites
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .collection('Favorites')
            .add({
              'productId': product.productId,
              'discountedPrice': product.discountedPrice,
              'colors': product.colors,
              'createdDate': product.createdDate,
              'images': product.images,
              'salesNumber': product.salesNumber,
              'sizes': product.sizes,
              'title': product.title,
              'price': product.price,
              'categoryId': product.categoryId,
            });
        return true; // Product added to favorites
      }
    } catch (e) {
      throw Exception(
        'Failed to add or remove favorite product. Please try again.',
      );
    }
  }

  Future<bool> isFavorite(String productId) async {
    try {
      var user = auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      var products =
          await firestore
              .collection("Users")
              .doc(user.uid)
              .collection('Favorites')
              .where('productId', isEqualTo: productId)
              .get();

      return products.docs.isNotEmpty;
    } catch (e) {
      log('Error in isFavorite: $e');
      throw Exception(
        'Failed to check if product is favorite. Please try again.',
      );
    }
  }

  Stream<List<ProductEntity>> getFavoritesProducts() {
    try {
      var user = auth.currentUser;

      return firestore
          .collection("Users")
          .doc(user!.uid)
          .collection('Favorites')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return ProductModel.fromMap(doc.data()).toEntity();
            }).toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch favorite products. Please try again.');
    }
  }
}
