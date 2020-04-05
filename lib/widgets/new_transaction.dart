import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final title = _titleController.text.toString();
    final amount = double.parse(_amountController.text.toString());

    if (title.isEmpty || amount < 0) {
      return;
    }

    widget.addTransaction(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
                child: Text('Add transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: () => _submitData())
          ],
        ),
      ),
    );
  }
}
