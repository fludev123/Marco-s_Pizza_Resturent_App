


import 'cart_item.dart';
import 'package:flutter/foundation.dart';



class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void clearInitialCart() {
    _cartItems.clear();
  }

  void addToCart(String itemName, double price, {int quantity = 1}) {
    // Check if the item is already in the cart
    int index = _cartItems.indexWhere((item) => item.itemName == itemName);

    if (index != -1) {
      // If the item is already in the cart, update its quantity
      _cartItems[index] = CartItem(
        itemName: itemName,
        price: price,
        quantity: _cartItems[index].quantity + quantity,
      );
    } else {
      // If the item is not in the cart, add it with the specified quantity
      _cartItems.add(CartItem(
        itemName: itemName,
        price: price,
        quantity: quantity,
      ));
    }

    // Notify listeners to update the UI
    notifyListeners();
  }


  void reduceQuantity(String itemName) {
    int index = _cartItems.indexWhere((item) => item.itemName == itemName);

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index] = CartItem(
          itemName: itemName,
          price: _cartItems[index].price,
          quantity: _cartItems[index].quantity - 1,
        );
      } else {
        _cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  int getQuantity(String itemName) {
    int index = _cartItems.indexWhere((item) => item.itemName == itemName);
    return index != -1 ? _cartItems[index].quantity : 0;
  }

  double getTotalCost() {
    return _cartItems.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
  }
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}



