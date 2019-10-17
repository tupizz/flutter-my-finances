import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './no_transaction.dart';

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
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'R\$ ',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                    '${transactions[index].amount.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat('hh:mm d/M/yy')
                            .format(transactions[index].date),
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTransactions(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
      );
    });
  }
}
