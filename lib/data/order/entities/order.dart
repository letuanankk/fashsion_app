import 'order_status.dart';
import 'product_ordered.dart';

class OrderEntity {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;
  final String code;
  final List<OrderStatusEntity> orderStatus;

  OrderEntity({
    required this.products,
    required this.createdDate,
    required this.shippingAddress,
    required this.itemCount,
    required this.totalPrice,
    required this.code,
    required this.orderStatus,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      products: List<ProductOrderedEntity>.from(
        map['products']?.map((x) => ProductOrderedEntity.fromMap(x)) ?? [],
      ),
      createdDate: map['createdDate'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
      itemCount: map['itemCount']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      code: map['code'] ?? '',
      orderStatus: List<OrderStatusEntity>.from(
        map['orderStatus']?.map((x) => OrderStatusEntity.fromMap(x)) ?? [],
      ),
    );
  }
}
