import 'package:scannic/models/product.dart';

class Transaction {
  final String id;
  List<Product> items;
  final double totalAmount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
  });

  // Convert Transaction object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items':
          items
              .map((product) => product.toJson())
              .toList(), // Convert Products to JSON
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
    };
  }

  // Convert JSON to Transaction object
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      items:
          (json['items'] as List)
              .map((item) => Product.fromJson(item as Map<String, dynamic>))
              .toList(), // Ensure correct type conversion
      totalAmount: (json['totalAmount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
