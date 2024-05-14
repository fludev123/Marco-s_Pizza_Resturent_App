import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_item.dart';
import 'custom_app_bar.dart';
class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar:  CustomAppBar(title: "Checkout"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Display a summary of items in the cart
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(cartItem.itemName),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text(
                      'Price: ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Total: ${cartProvider.getTotalCost().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate the input fields
                if (_validateInputs()) {
                  cartProvider.clearCart();
                  showOrderConfirmation();
                } else {
                  _showErrorDialog();
                }
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all the required fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Placed'),
          content: Text('Thank you for your order!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
