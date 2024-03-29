import 'dart:io';

import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './NewTransactionWidget/new_transaction.dart';
import './ChartWidget/chart.dart';
import './TransactionListWidget/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 210.9,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      title: 'New T-shirts',
      amount: 129.9,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't3',
      title: 'iPhone',
      amount: 333.90,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
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
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Minhas Finanças'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showNewTransactionDialog(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              _buildLandscapeContent(
                context,
                mediaQuery,
                appBar,
              ),
            if (!isLandscape)
              _buildPortraitContent(
                mediaQuery,
                appBar,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _showNewTransactionDialog(context),
            ),
    );
  }

  /**
   *  Celular na vertical
   */
  Column _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return Column(
      children: <Widget>[
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(recentTransactions: _recentTransactions),
        ),
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7,
          child: TransactionList(
            transactions: _userTransactions,
            deleteTransactions: _deleteTransaction,
          ),
        )
      ],
    );
  }

  /**
   *  Celular na horizontal
   */
  Column _buildLandscapeContent(
      BuildContext context, MediaQueryData mediaQuery, AppBar appBar) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Mostrar gráfico'),
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
        _showChart
            ? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: Chart(recentTransactions: _recentTransactions),
              )
            : Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(
                  transactions: _userTransactions,
                  deleteTransactions: _deleteTransaction,
                ),
              )
      ],
    );
  }
}
