import 'dart:convert';

class ClientModel {
  final int id;
  final String name;
  final String lastName;
  final String phone;
  final String district;
  final String street;
  final int number;
  final double due;
  final String userId;

  ClientModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.district,
    required this.street,
    required this.number,
    required this.due,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'last_name': lastName,
      'phone': phone,
      'district': district,
      'street': street,
      'number': number,
      'due': due,
      'user_id': userId,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? 1,
      name: map['name'] ?? '',
      lastName: map['last_name'] ?? '',
      phone: map['phone'] ?? '',
      district: map['district'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? 1,
      due: (map['due'] ?? 0.0) as double,
      userId: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
