import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannic/data/dummy_data.dart';
import 'package:scannic/providers/cart_provider.dart';
import 'package:scannic/screens/cart_screen.dart';
import 'package:scannic/screens/item_details_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dummyData.length,
                itemBuilder:
                    (context, index) => Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ItemDetailsScreen(
                                          product: dummyData[index],
                                        ),
                                  ),
                                );
                              },
                              child: Text('Display Cart'),
                            ),
                            Text(dummyData[index].name),
                            SizedBox(width: 8),
                            Text(dummyData[index].price.toString()),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                cartProvider.addToCart(
                                  dummyData[index],
                                  dummyData[index].stock,
                                );
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
