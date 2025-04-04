import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scannic/models/product.dart';
import 'package:scannic/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];
  SharedPreferences? _prefs;

  TransactionProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs == null) {
      return;
    }
    await _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final String? data = _prefs?.getString('transactions');
    if (data != null) {
      List<dynamic> decoded = json.decode(data);
      transactions = decoded.map((item) => Transaction.fromJson(item)).toList();
      notifyListeners();
    }
  }

  void _saveTransactions() {
    if (_prefs == null) return;
    final String encodedData = json.encode(
      transactions.map((t) => t.toJson()).toList(),
    );
    _prefs!.setString('transactions', encodedData);
  }

  void addTransaction(List<Product> cartItems, double total) {
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List<Product>.from(cartItems), // Ensure proper type
      totalAmount: total,
      date: DateTime.now(),
    );

    transactions.insert(0, transaction); // Add the newest transaction first
    _saveTransactions();
    notifyListeners();
  }
}
