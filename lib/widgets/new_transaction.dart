import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_textButton.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then(
      (value) {
        if (value == null) {
          return;
        }
        //Les Statefull widgets doivent utilisés setState pour changer un element de la classe
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Titre',
                  focusColor: Colors.green,
                ),
                controller: _titleController,
                onSubmitted: (_) =>
                    // convention "_" to tell that we have an argument but we will not use it and it's required
                    _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Montant',
                  focusColor: Colors.green,
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) =>
                    // convention "_" to tell that we have an argument but we will not use it and it's required
                    _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(_selectedDate == null
                          ? 'Aucune date choisie !'
                          : 'Date choisie : ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveTextButton('Choisir la date', _displayDatePicker)
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: Text("Ajouter une transaction"),
                  // textColor: Colors.white,
                ),
                margin: EdgeInsets.only(bottom: 0, top: 15),
              )
            ],
          ),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            //pour augmenter le padding bottonm du clavier en fonction de sa taille
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
        ),
      ),
    );
  }
}
