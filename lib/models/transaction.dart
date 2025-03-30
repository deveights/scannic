import 'package:scannic/models/product.dart';

class Transaction {
  final String id;
  final List<Product> items;
  final double totalAmount;
  final DateTime? date;

  Transaction({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'],
    items: json['items'],
    totalAmount: json['totalAmount'],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items,
    'totalAmount': totalAmount,
    'date': date?.toIso8601String(),
  };
}
