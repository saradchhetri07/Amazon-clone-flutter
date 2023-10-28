import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final double totalPrice;
  final String address;
  final String userId;
  final int orderAt;
  final int status;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.totalPrice,
    required this.address,
    required this.userId,
    required this.orderAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'address': address,
      'userId': userId,
      'orderAt': orderAt,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderAt: map['orderAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
