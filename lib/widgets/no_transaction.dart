import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: 100,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Sem transações realizadas ainda, adicione sua primeira transação.',
          style: Theme.of(context).textTheme.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
