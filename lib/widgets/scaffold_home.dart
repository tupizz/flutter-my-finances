import 'package:flutter/material.dart';

import './new_transaction.dart';
import './chart.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 210.9,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New T-shirts',
    //   amount: 129.9,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'iPhone',
    //   amount: 333.90,
    //   date: DateTime.now().subtract(Duration(days: 5)),
    // ),
  ];

  bool _showChart = true;

  void _addNewTransaction(String gasto, double quantia, DateTime chosenDate) {
    final transaction = Transaction(
      title: gasto,
      amount: quantia,
      id: DateTime.now().toIso8601String(),
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showNewTransactionDialog(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Minhas Finanças'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showNewTransactionDialog(context),
        )
      ],
    );

    final transactionListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTransactions: _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Mostrar gráfico'),
                  Switch(
                    value: _showChart,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!isLandscape) transactionListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(recentTransactions: _recentTransactions),
                    )
                  : transactionListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransactionDialog(context),
      ),
    );
  }
}
