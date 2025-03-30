import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scannic/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:scannic/screens/item_details_screen.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});

  final dateFormatter = DateFormat.yMMMd().add_jm();

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: Column(
        children: [
          ...transactions.map(
            (transac) => Column(
              children: [
                ...transac.items.map(
                  (prod) => Center(
                    child: Card(
                      child: Column(
                        children: [
                          Text(prod.name),
                          Text(prod.price.toStringAsFixed(2)),
                          Text(prod.quantity.toString()),
                          Text(transac.totalAmount.toStringAsFixed(2)),
                          Text(dateFormatter.format(transac.date!)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ItemDetailsScreen(product: prod),
                                ),
                              );
                            },
                            child: Text('Order Again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
