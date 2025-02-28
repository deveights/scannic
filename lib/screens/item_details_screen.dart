import 'package:flutter/material.dart';
import 'package:scannic/models/product.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? 'Product Not Registered')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white70,
                child:
                    product.image == null
                        ? Text('No Image Provided')
                        : Image.asset(product.image!, height: 300),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    product.name ?? 'Product Not Registered',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.clip,
                  ),
                  Spacer(),
                  Text.rich(
                    TextSpan(
                      text: '₱${product.price ?? 'Product Not Registered'}',
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
            ],
          ),
        ),
      ),
    );
  }
}
