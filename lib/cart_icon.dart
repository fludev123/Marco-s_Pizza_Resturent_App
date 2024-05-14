import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'orderPage.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) => Stack(
        children: [
          IconButton(
            icon: Icon(Icons.shopping_cart,size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage()),
              );
            },
          ),
          if (cartProvider.cartItems.isNotEmpty)
            Positioned(
              right: 6,
              top: 6,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 7,
                child: Text(
                  cartProvider.cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
