import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // A Linha na qual possui uma chance de estourar o tamanho envolvemos-na no objeto FittedBOx
        FittedBox(
          child: Row(
            children: <Widget>[
              Text(
                'R\$',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                '${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          // Uma stack é uma forma de construir componentes com a mesma ideia de camadas do photoshop
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  margin: EdgeInsets.all(1.7),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
