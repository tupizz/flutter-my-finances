import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class TransactionItemOfList extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransactions;

  const TransactionItemOfList({
    @required this.transaction,
    @required this.deleteTransactions,
  });

  @override
  Widget build(BuildContext context) {
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
                  Text('${transaction.amount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('hh:mm d/M/yy').format(transaction.date),
          style: Theme.of(context).textTheme.subtitle,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransactions(transaction.id),
        ),
      ),
    );
  }
}
