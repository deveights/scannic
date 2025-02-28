class Product {
  final String id;
  final String? name;
  final double? price;
  final String? image;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: json['image'],
  );
}
