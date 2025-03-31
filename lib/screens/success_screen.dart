import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scannic/providers/cart_provider.dart';
import 'package:scannic/widgets/custom_navbar.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Column(
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
                  RichText(
                    text: TextSpan(
                      text: '₱ ${cartProvider.totalAmount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Order Placed Successfully!',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        'Your order has been successfully placed and is now being processed.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => CustomNavbar(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child:
                        isLoading
                            ? Transform.scale(
                              scale: 0.6,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : Text('Continue Shopping'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
