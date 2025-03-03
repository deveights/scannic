import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scannic/providers/cart_provider.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Lottie.asset(
                  'assets/animations/lottie_success.json',
                  repeat: false,
                ),
              ),
              Consumer<CartProvider>(
                builder: (context, total, child) {
                  return Text(
                    '₱${total.totalAmount}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    'Order Placed Successfully! Thank you for your order! Your order has been successfully placed and is now being processed.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
