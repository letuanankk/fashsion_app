// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'color.dart';

class ProductEntity {
  final String categoryId;
  final List < ProductColorEntity > colors;
  final Timestamp createdDate;
  final num discountedPrice;
  final List < String > images;
  final num price;
  final List < int > sizes;
  final String productId;
  final int salesNumber;
  final String title;

  ProductEntity({
    required this.categoryId,
    required this.colors,
    required this.createdDate,
    required this.discountedPrice,
    required this.images,
    required this.price,
    required this.sizes,
    required this.productId,
    required this.salesNumber,
    required this.title
  });

  // toMap
  Map < String, dynamic > toMap() {
    return {
      'categoryId': categoryId,
      'colors': colors.map((color) => color.toMap()).toList(),
      'createdDate': createdDate,
      'discountedPrice': discountedPrice,
      'images': images,
      'price': price,
      'sizes': sizes,
      'productId': productId,
      'salesNumber': salesNumber,
      'title': title
    };
  }
}
