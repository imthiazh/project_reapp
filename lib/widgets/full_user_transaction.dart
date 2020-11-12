import 'package:reapp/models/transaction.dart';
import 'package:reapp/widgets/inputForm.dart';
import 'package:reapp/widgets/listTransaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FullUserTransaction extends StatefulWidget {
  @override
  _FullUserTransactionState createState() => _FullUserTransactionState();
}

class _FullUserTransactionState extends State<FullUserTransaction> {
  


void addTx(String title1, double amount2){
  Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title1,
      amount: amount2,
      date: DateTime.now(),
      progress: 0.00
    );

  setState(() {
    transactions.add(newTransaction);
  });
}

final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
      progress: 0.00
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
      progress: 0.00
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          InputForm(addTx),
          ListTransaction(transactions, false)
      ],
    );
  }
}