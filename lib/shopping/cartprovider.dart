import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _cart = {};
  //Getters
  Map<String, int> get cart => _cart;

  int get cartCount => _cart.length;
  int get count => _cart.isNotEmpty ? _cart.values.reduce((a, b) => a + b) : 0;
  //reduce method - add each value from the list

  void addToCart(String index, int quantity) {
    if (_cart.containsKey(index)) {
      _cart[index] = _cart[index]! + quantity;
    } else {
      _cart[index] = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(String index, int quantity) {
    if (_cart.containsKey(index)) {
      _cart[index] = (_cart[index]! - 1).clamp(0, double.infinity).toInt();
      if (_cart[index] == 0) _cart.remove(index);
      notifyListeners();
    }
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }
}