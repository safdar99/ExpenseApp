import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function(String id) deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transcations added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/NoTransactions.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              '\$${userTransactions[index].amount}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${userTransactions[index].title}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          '${DateFormat.yMMMd().format(userTransactions[index].time)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTransaction(userTransactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              ));
  }
}
