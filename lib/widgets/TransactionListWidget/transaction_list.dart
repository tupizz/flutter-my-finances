import 'package:flutter/material.dart';

import './no_transaction.dart';
import './transaction_item.dart';
import '../../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;

  TransactionList({this.transactions, this.deleteTransactions});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: transactions.isEmpty
            ? NoTransactions(heightBox: constraints.maxHeight * 0.5)
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return new TransactionItemOfList(
                      transaction: transactions[index],
                      deleteTransactions: deleteTransactions);
                },
                itemCount: transactions.length,
              ),
      );
    });
  }
}
