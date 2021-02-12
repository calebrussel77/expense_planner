import '../widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map> get groupedTransactionValues {
    //permet de generer une liste de transaction sous 07jours
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      ); // on enlève le nombre de jour par rapport à la date d'aujourdh'hui. exple : 13/12/2012 - 0jours => c'est aujourdh'ui
      var totalSum = 0.0;

      for (var singleTransaction in recentTransactions) {
        if (singleTransaction.date.day == weekDay.day &&
            singleTransaction.date.month == weekDay.month &&
            singleTransaction.date.year == weekDay.year) {
          totalSum += singleTransaction.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            print(data['amount']);

            return Flexible(
              fit: FlexFit.tight, // equivalent de flex-grow
              child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPctOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
