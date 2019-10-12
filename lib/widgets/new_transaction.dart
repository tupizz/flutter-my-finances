import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountControler = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Gasto',
                  border: OutlineInputBorder(gapPadding: 2),
                ),
                onSubmitted: (_) => submitData,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: amountControler,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Quantia',
                  border: OutlineInputBorder(gapPadding: 2),
                ),
                onSubmitted: (_) => submitData,
              ),
            ),
            FlatButton(
              child: Text('Adicionar transação'),
              onPressed: submitData,
              textColor: Colors.purple,
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
