import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountControler = TextEditingController();

  DateTime _choosedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _choosedDate == null) {
      return;
    }

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _choosedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final choosedDate = await showDatePicker(
      locale: Locale('pt', 'BR'),
      context: context,
      initialDate: _choosedDate,
      firstDate: DateTime.now().subtract(Duration(days: 60)),
      lastDate: DateTime.now(),
    );
    print(choosedDate);

    if (choosedDate == null) {
      return;
    }

    setState(() {
      _choosedDate = choosedDate;
    });
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
                autofocus: true,
                style: TextStyle(fontSize: 14),
                controller: _titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  isDense: true,
                  labelText: 'Gasto',
                  border: OutlineInputBorder(gapPadding: 2),
                ),
                onSubmitted: (_) => _submitData,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _amountControler,
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  isDense: true,
                  labelText: 'Quantia',
                  border: OutlineInputBorder(gapPadding: 2),
                ),
                onSubmitted: (_) => _submitData,
              ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(_choosedDate == null
                        ? 'Nenhuma data escolhida'
                        : DateFormat('dd/M/yy').format(_choosedDate)),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Escolher data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text('Adicionar transação'),
              onPressed: _submitData,
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
