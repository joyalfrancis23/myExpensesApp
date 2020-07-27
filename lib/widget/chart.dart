import 'package:expense_app/model/Transactions.dart';
import 'package:expense_app/widget/chart_bar.dart';
import 'package:flutter/material.dart';
import '../model/Transactions.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {

final List<Transactions> recentTransaction;
Chart(this.recentTransaction);

  List<Map<String,Object>> get groupedTransactionValues{
      return List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index),);
        double totalSum = 0.0;
        for(var i = 0; i< recentTransaction.length; i++){
          if(
            recentTransaction[i].date.day == weekDay.day  && 
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year
          ){
            totalSum += recentTransaction[i].amount;
          }
        }
        print(DateFormat.E().format(weekDay));
        print(totalSum);
        return{'day':DateFormat.EEEE().format(weekDay).substring(0,3),'amount':totalSum};
      }
      
      ).reversed.toList();
    }
    double get totalSpending{
      return groupedTransactionValues.fold(0.0, (previousValue, element){
        return previousValue + element['amount'];
      });
    }
  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map(
            (data){
              return Flexible(
                            fit: FlexFit.tight,
                            child: ChartBar(data['day'], data['amount'],
                totalSpending == 0 ? 0.0:
                (data['amount'] as double) / totalSpending,),
              );
            }
          ).toList()

        ),
      ),
    );
    
  }
}