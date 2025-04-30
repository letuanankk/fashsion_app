import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/data/category/entity/category.dart';


final categoryRepositoryProvider = Provider(
  (ref) => CategoryRepository(
    storage: FirebaseStorage.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class CategoryRepository {
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  CategoryRepository({required this.storage, required this.firestore});

  Future<List<CategoryEntity>> getCategories() async {
  try {
    var categories =
        await FirebaseFirestore.instance.collection('Categories').get();
    return categories.docs.map((e) => e.data()).map((e) {
      return CategoryEntity(
        title: e['title'],
        categoryId: e['categoryId'],
        image: e['image'],
      );
    }).toList();
  } catch (e) {
    throw Exception('Failed to fetch categories. Please try again.');
  }
}
}
