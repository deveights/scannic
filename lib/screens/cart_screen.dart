import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannic/providers/cart_provider.dart';
import 'package:scannic/screens/success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), scrolledUnderElevation: 0),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 120, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...cart.cart.map(
                        (product) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Card(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Image.asset(
                                    product.image,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        product.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '₱ ${product.price}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 4),
                                  padding: EdgeInsets.only(
                                    right: 4,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cart.addToCart(
                                            product,
                                            product.stock,
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        product.quantity.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cart.removeItem(product.id);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    height: 120,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(
                                text:
                                    '₱ ${cart.totalAmount == 0 ? 0 : cart.totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(),
                              ),
                            );
                          },
                          child:
                              isLoading
                                  ? Transform.scale(
                                    scale: 0.6,
                                    child: CircularProgressIndicator(),
                                  )
                                  : Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
