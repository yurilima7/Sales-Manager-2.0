import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final double totalVendido;
  final double recebido;
  final double receber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.totalVendido,
    required this.recebido,
    required this.receber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'total_vendido': totalVendido,
      'recebido': recebido,
      'receber': receber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 1,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      totalVendido: (map['total_vendido'] ?? 0.0) as double,
      recebido: (map['recebido'] ?? 0.0) as double,
      receber: (map['receber'] ?? 0.0) as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}