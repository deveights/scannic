import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannic/models/product.dart';
import 'package:scannic/providers/cart_provider.dart';
import 'package:scannic/screens/cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                    badgeContent: SizedBox(
                      width: 12,
                      height: 12,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(value.cartItemCount.toString()),
                      ),
                    ),
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeAnimation: badges.BadgeAnimation.slide(),
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white70,
                padding: EdgeInsets.all(8),
                child: Image.asset(product.image, height: 300),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.clip,
                  ),
                  Spacer(),
                  Text.rich(
                    TextSpan(
                      text: '₱${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Code: ${product.id}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      cart.addToCart(product, product.stock);
                    },
                    child: Text(
                      'Add to cart',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
