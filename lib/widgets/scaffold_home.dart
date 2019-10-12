import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.9,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New T-shirts',
      amount: 129.9,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String gasto, double quantia) {
    final transaction = Transaction(
      title: gasto,
      amount: quantia,
      id: DateTime.now().toIso8601String(),
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _showNewTransactionDialog(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Finanças'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNewTransactionDialog(context),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TransactionList(transactions: _userTransactions),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransactionDialog(context),
      ),
    );
  }
}
