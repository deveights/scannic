class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.stock,
  });

  Product copyWith({int? quantity, int? stock}) {
    return Product(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
      stock: stock ?? this.stock,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: json['image'],
    quantity: json['quantity'],
    stock: json['stock'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'image': image,
    'quantity': quantity,
    'stock': stock,
  };
}
