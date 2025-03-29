import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scannic/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<Product> cart = [];

  CartProvider() {
    _loadCart();
  }

  double get totalAmount =>
      cart.fold(0, (total, item) => total + (item.price * item.quantity));

  int get cartItemCount {
    return cart.fold(0, (total, item) => total + item.quantity);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart');
    if (cartData != null) {
      List<dynamic> decoded = json.decode(cartData);
      cart = decoded.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      cart.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('cart', encodedData);
  }

  void addToCart(Product product, int stock) {
    int index = cart.indexWhere((prod) => prod.id == product.id);
    if (index != -1) {
      //if item exists, increase quantity(but not more than stock)
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
    _saveCart();
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
    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    _saveCart();
    notifyListeners();
  }
}
