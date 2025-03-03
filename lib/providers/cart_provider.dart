import 'package:flutter/material.dart';
import 'package:scannic/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cart = [];

  double get totalAmount =>
      cart.fold(0, (total, item) => total + (item.price * item.quantity));

  int get cartItemCount {
    return cart.fold(0, (total, item) => total + item.quantity);
  }

  void addToCart(Product product, int stock) {
    int index = cart.indexWhere((prod) => prod.id == product.id);
    if (index != -1) {
      //if item exists, increase quantity(but not beyond stock)
      int newQuantity = cart[index].quantity + 1;
      if (newQuantity <= stock) {
        cart[index] = cart[index].copyWith(quantity: newQuantity);
      } else {
        debugPrint('Stock Limit Reached');
      }
    } else {
      //if item doesnt exist, add with quantity = 1
      if (stock > 0) {
        cart.add(
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            image: product.image,
            quantity: 1,
            stock: product.stock,
          ),
        );
      } else {
        debugPrint('Out Of Stock!');
      }
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    int index = cart.indexWhere((item) => item.id == productId);

    if (index == -1) return;

    Product existingItem = cart[index];

    if (existingItem.quantity > 1) {
      cart[index] = existingItem.copyWith(quantity: existingItem.quantity - 1);
    } else {
      cart.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
