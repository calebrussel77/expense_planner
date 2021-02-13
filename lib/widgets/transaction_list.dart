import 'package:expense_planner/widgets/transaction_single.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.75,
                  child: Image.asset(
                    "assets/images/Startup life-pana.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Aucune transaction ajoutée !",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionSingle(transactions[index], deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
