import 'dart:convert';

class SaleModel {
  final int id;
  final String productName;
  final double price;
  final int quantity;
  final String day;
  final double total;
  final String clientId;

  SaleModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.day,
    required this.total,
    required this.clientId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
      'day': day,
      'total': total,
      'client_id': clientId,
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'] ?? 1,
      productName: map['product_name'] ?? '',
      price: (map['price'] ?? 0.0) as double,
      quantity: map['quantity'] ?? 1,
      day: map['day'] ?? '',
      total: (map['total'] ?? 0.0) as double,
      clientId: map['client_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleModel.fromJson(String source) => SaleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
