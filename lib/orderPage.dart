import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_item.dart';
import 'custom_app_bar.dart';
import 'checkout_page.dart';


class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Order Summary"),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartProvider.cartItems[index];
          return ListTile(
            title: Text(cartItem.itemName),
            subtitle: Text('Quantity: ${cartItem.quantity}'),
            trailing: Text('Price: ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: ${cartProvider.getTotalCost().toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}