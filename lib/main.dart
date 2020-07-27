

import 'package:expense_app/model/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widget/chart.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import './model/Transactions.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp ,
   DeviceOrientation.portraitDown,
   
 ]);
 runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'My Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        
         
      ),
      
      home: MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    
  ];

  List <Transactions> get _recentTransaction{
    return _userTransactions.where((element){
      return element.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transactions(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  void _deleteTransaction(String id){

setState(() {
  
  _userTransactions.removeWhere((element) => element.id==id,);
});

  }
 

  @override
  Widget build(BuildContext context) {
     final appBar = AppBar(
        title: Text('My Expenses App', style: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 22),),
        
          
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      );
    return Scaffold(
      appBar: appBar,
      
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height-appBar.preferredSize.height)*0.3 - MediaQuery.of(context).padding.top ,
              child: Chart(_recentTransaction,)),
            Container(
              height:  (MediaQuery.of(context).size.height-appBar.preferredSize.height)*0.7 - MediaQuery.of(context).padding.top ,
              child: TransactionsList(_userTransactions,_deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        
      ),
    );
  }
}
