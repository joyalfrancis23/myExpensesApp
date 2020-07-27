import 'package:flutter/material.dart';
import '../model/Transactions.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final Function deleteTxt;
  final List<Transactions> transactions;
  TransactionsList(this.transactions,this.deleteTxt);
  
  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: transactions.isEmpty? 
      Column(
        children: <Widget>
        [SizedBox(height: 100,),
          Text('No Transactions added !!!',
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.grey ,
            fontSize: 23
          ),
          ),
          SizedBox(height: 50,),
          Container(
            height: 100,
            child: Image.asset('assets/Images/icons8-receipt-declined-64.png',fit: BoxFit.cover,)),

        ],
      )
       : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4,horizontal: 9),
            elevation: 2,
                      child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.cyan[600],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text('₹${transactions[index].amount}',style: TextStyle(color: Colors.white),)),
                      
                      )),
              ),
              title: Text(transactions[index].title,
              style: TextStyle(fontFamily: 'Quicksand',color: Colors.black,fontWeight: FontWeight.bold,),
              ),
              subtitle: Text(DateFormat.yMMMd().format( transactions[index].date),),
              trailing: IconButton(
                
              icon: Icon(Icons.delete),

              color: Colors.red[900],
              
              onPressed: (){

                deleteTxt(transactions[index].id);

              }
               
               )
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
    
  }
}

