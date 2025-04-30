class ProductOrderedEntity {
  final String productId;
  final String productTitle;
  final int productQuantity;
  final String productColor;
  final int productSize;
  final double productPrice;
  final double totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedEntity({
    required this.productId,
    required this.productTitle,
    required this.productQuantity,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
    required this.id
  });

  factory ProductOrderedEntity.fromMap(Map<String, dynamic> map) {
    return ProductOrderedEntity(
      productId: map['productId'] ?? '',
      productTitle: map['productTitle'] ?? '',
      productQuantity: map['productQuantity'] ?? 0,
      productColor: map['productColor'] ?? '',
      productSize: map['productSize'] ?? 0,
      productPrice: map['productPrice']?.toDouble() ?? 0.0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      productImage: map['productImage'] ?? '',
      createdDate: map['createdDate'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
