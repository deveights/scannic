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
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index].items;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.2,
                  blurRadius: 0.1,
                  offset: Offset(0, 1),
                  color: Colors.grey.withAlpha((255 * 0.7).toInt()),
                ),
              ],
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ...item.map(
                      (item) => SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Image.asset(item.image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateFormatter.format(transactions[index].date!)),
                    Text(transactions[index].totalAmount.toString()),
                  ],
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    print(item.length);
                  },
                  child: Text('Order Again'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
