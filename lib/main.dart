import 'package:flutter/material.dart';
 
import './models/transaction.dart';
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
          fontFamily: "San-Francisco",
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
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

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _displayInputTransactions(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior:
                HitTestBehavior.opaque, //important for the gesture behavior
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              child: Card(
                //Cards By default depends of the size of his child
                //Text widget have the size of the text so you need a container
                //to modify the size.
                child: Text("Chart"),
                elevation: 5,
              ),
              width: double.infinity,
            ),
            _userTransactions.isEmpty
                ? Column(
                    children: [
                      Text(
                        "Aucune Transaction ajout !",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ],
                  )
                : TransactionList(_userTransactions),
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
