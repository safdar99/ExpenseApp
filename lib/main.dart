import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [];

  List<Transaction> get _recentTransactions {
    return userTransactions.where((txn) {
      return txn.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final txn = Transaction(
        title: title,
        amount: amount,
        time: chosenDate,
        id: chosenDate.toString());

    setState(() {
      userTransactions.add(txn);
    });
  }

  void _slideInAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(userTransactions, _deleteTransaction)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _slideInAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
