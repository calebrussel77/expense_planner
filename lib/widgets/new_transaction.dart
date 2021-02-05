import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addNewTransaction(
        titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Titre',
                focusColor: Colors.green,
              ),
              controller: titleController,
              onSubmitted: (_) =>
                  // convention "_" to tell that we have an argument but we will not use it and it's required
                  submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Montant',
                focusColor: Colors.green,
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) =>
                  // convention "_" to tell that we have an argument but we will not use it and it's required
                  submitData(),
            ),
            Container(
              child: RaisedButton(
                onPressed: submitData,
                child: Text("Ajouter une transaction"),
                textColor: Colors.white,
                color: Colors.green,
              ),
              margin: EdgeInsets.only(bottom: 0, top: 8),
            )
          ],
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
