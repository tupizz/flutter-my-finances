import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  double heightBox;

  NoTransactions({this.heightBox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: heightBox,
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
