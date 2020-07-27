import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
final Function addTx;

NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final titleController = TextEditingController();

final amountController = TextEditingController();
DateTime _selectedDate;
void submitData(){
  if(amountController.text.isEmpty){
    return;
  }
  final enteredTitle=titleController.text;
  final enteredAmount=double.parse(amountController.text);
  if(enteredTitle.isEmpty|| enteredAmount<=0||_selectedDate == null){
    return;
  }

  widget.addTx(
                    titleController.text,
                    double.parse(amountController.text),
                    _selectedDate,
                  );
                  Navigator.of(context).pop();
                
}

void _presentDatePicker(){
  showDatePicker(
    context: context, 
    initialDate: DateTime.now() ,
    firstDate: DateTime(2019), 
    lastDate: DateTime.now(),).then((value) {
      if (value == null){
        return;
      }
      setState(() {
        _selectedDate = value;
      });
      
    }
    
    );

}

  @override
  Widget build(BuildContext context) {
    return Card(
          
          child:Container(
            
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_)=> submitData(),
                  ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  onSubmitted: (_)=>submitData(),
                  keyboardType: TextInputType.number,
                  ),
                  Container(
                    height: 110,
                    child: Row(
                      children: <Widget>[
                       _selectedDate == null ?
                        Expanded(
                                                  child: Text('Please choose a date',
                          style: TextStyle(fontFamily: 'Quicksand',
                          color: Colors.grey,
                          ),
                          ),
                        ):
                        Text(DateFormat.yMMMd().format(_selectedDate),),
                        
                        FlatButton(onPressed: (){
                          _presentDatePicker();
                        }, child: Text('Pick a Date',style: TextStyle(fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[700],
                         ),))
                      ],
                    ),
                  ),
                RaisedButton(onPressed: (){
                  submitData();
                  
                  
                }, child: Text('Add Transaction'),
                color: Colors.cyan[600],
                textColor: Colors.white,elevation: 4,
                ),
              ],
            ),
          )
        );
  }
}