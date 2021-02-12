import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          errorColor: Colors.red,
          fontFamily: "San-Francisco",
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: "t1", title: "New Shoes", amount: 200.5, date: DateTime.now()),
    // Transaction(
    //     id: "t2",
    //     title: "The men Curttles",
    //     amount: 250.5,
    //     date: DateTime.now()),
  ];

//dynamique calculator properties => getter;
  List<Transaction> get _recentTransactions {
    //on récupère les transactions qui sont après la date d'aujourd'hui moins 07jours.
    //ce sont elles les transactions les plus recentes.

    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList(); // where return an iterable but we expected a list
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _displayInputTransactions(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: () {},
            child: SingleChildScrollView(
                child: NewTransaction(_addNewTransaction)),
            behavior:
                HitTestBehavior.opaque, //important for the gesture behavior
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Expense Planner',
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _displayInputTransactions(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //CrossAxisAlignment is use to align items left to right on a column
          //and top to bottom on a row
          //MainAxisAlignment is use to align items top to bottom on a column
          //and left to right on a row.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            _userTransactions.isEmpty
                ? Column(
                    children: [
                      Container(
                        height: 320,
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
                  )
                : TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _displayInputTransactions(context),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
