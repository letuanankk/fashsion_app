// ignore_for_file: public_member_api_docs, sort_constructors_first

import '/../../data/order/models/product_ordered.dart';

import '../../../domain/order/entities/product_ordered.dart';
import 'order_status.dart';

class OrderRegistrationReq {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;
  final String code;
  final List<OrderStatusModel> orderStatus;

  OrderRegistrationReq({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalPrice,
    required this.shippingAddress,
    required this.code,
    required this.orderStatus
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
      'code' : code,
      'orderStatus' : orderStatus.map((e) => e.toEntity()).toList(),
    };
  }
}
