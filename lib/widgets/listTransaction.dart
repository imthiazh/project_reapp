import 'package:reapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ListTransaction extends StatelessWidget {
  
  final List<Transaction> transactions;
  final bool home_screen;

  ListTransaction(this.transactions, this.home_screen);

  


  @override
  Widget build(BuildContext context) {
    print("Amount is:"+transactions[0].amount.toString());
    return !home_screen ? Container(
              height: 500,
              child: ListView(
              children: 
                // !home_screen ? 
                transactions.map((tx) {
                  print(tx.id);
                  
                  return (tx.progress == 100) ? Container(
                    // width: 210,
                    height: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(7))),
                      color: Colors.blue[50],
                      elevation: 10,
                      // color: Colors.white,
                      // child: Text(tx.title, style: TextStyle(color: Colors.white),),
                      child: Row(
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2
                              ),                            
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('\$${tx.amount.toStringAsFixed(2)}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // color: Colors.grey[700],
                              color: Colors.green[600],
                              fontFamily: 'OpenSans',
                              // fontColor: Colors.grey[700],
                            ),)
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 18,),
                            Text(tx.title, 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey[700],
                              color: Colors.green[600],
                              fontFamily: 'OpenSans'
                            ),),
                            // Text(DateFormat.yMMMd().format(tx.date),
                            //   style: TextStyle(
                            //     color: Colors.black,
                            // ),),
                            SizedBox(
                              height: 8,
                            ),
                            
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 200,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 1200,
                              percent: tx.progress / 100,
                                
                              center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                              fontFamily: 'OpenSans')),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.green,
                            
                            )
                            //  : 
                            // LinearPercentIndicator(
                            //   width: MediaQuery.of(context).size.width - 200,
                            //   animation: true,
                            //   lineHeight: 15.0,
                            //   animationDuration: 1200,
                            //   percent: tx.progress / 100,
                                
                            //   center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                            //   fontFamily: 'OpenSans')),
                            //   linearStrokeCap: LinearStrokeCap.roundAll,
                            //   progressColor: Colors.green,
                            // )
                            
                            ,
                          ],)
                        ],
                      ),
                    ),
                  ) : 
                  Container(
                    // width: 210,
                    height: 100,
                    child: (tx.progress == 100) ? Card(
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(7))),
                      color: Colors.green,
                      elevation: 10,
                      // color: Colors.white,
                      // child: Text(tx.title, style: TextStyle(color: Colors.white),),
                      child: Row(
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2
                              ),                            
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('\$${tx.amount.toStringAsFixed(2)}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // color: Colors.grey[700],
                              color: Colors.green[600],
                              fontFamily: 'OpenSans',
                              // fontColor: Colors.grey[700],
                            ),)
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 18,),
                            Text(tx.title, 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey[700],
                              color: Colors.green[600],
                              fontFamily: 'OpenSans'
                            ),),
                            // Text(DateFormat.yMMMd().format(tx.date),
                            //   style: TextStyle(
                            //     color: Colors.black,
                            // ),),
                            SizedBox(
                              height: 8,
                            ),
                            
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 200,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 1200,
                              percent: tx.progress / 100,
                                
                              center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                              fontFamily: 'OpenSans')),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.blue,
                            
                            )
                            //  : 
                            // LinearPercentIndicator(
                            //   width: MediaQuery.of(context).size.width - 200,
                            //   animation: true,
                            //   lineHeight: 15.0,
                            //   animationDuration: 1200,
                            //   percent: tx.progress / 100,
                                
                            //   center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                            //   fontFamily: 'OpenSans')),
                            //   linearStrokeCap: LinearStrokeCap.roundAll,
                            //   progressColor: Colors.green,
                            // )
                            
                            ,
                          ],)
                        ],
                      ),
                    ) : Card(
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(7))),
                      color: Colors.blue[50],
                      elevation: 10,
                      // color: Colors.white,
                      // child: Text(tx.title, style: TextStyle(color: Colors.white),),
                      child: Row(
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2
                              ),                            
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('\$${tx.amount.toStringAsFixed(2)}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // color: Colors.grey[700],
                              color: Colors.blue[600],
                              fontFamily: 'OpenSans',
                              // fontColor: Colors.grey[700],
                            ),)
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 18,),
                            Text(tx.title, 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey[700],
                              color: Colors.blue[600],
                              fontFamily: 'OpenSans'
                            ),),
                            // Text(DateFormat.yMMMd().format(tx.date),
                            //   style: TextStyle(
                            //     color: Colors.black,
                            // ),),
                            SizedBox(
                              height: 8,
                            ),
                            
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 200,
                              animation: true,
                              lineHeight: 15.0,
                              animationDuration: 1200,
                              percent: tx.progress / 100,
                                
                              center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                              fontFamily: 'OpenSans')),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.blue,
                            
                            )
                            //  : 
                            // LinearPercentIndicator(
                            //   width: MediaQuery.of(context).size.width - 200,
                            //   animation: true,
                            //   lineHeight: 15.0,
                            //   animationDuration: 1200,
                            //   percent: tx.progress / 100,
                                
                            //   center: Text(tx.progress.toString(), style: TextStyle(color: Colors.white,
                            //   fontFamily: 'OpenSans')),
                            //   linearStrokeCap: LinearStrokeCap.roundAll,
                            //   progressColor: Colors.green,
                            // )
                            
                            ,
                          ],)
                        ],
                      ),
                    ),
                  );
                }).toList()
                
                  
                )
              ) : Container(
              height: 100,
              child: ListView(
              children: 
              <Widget>[
                  Container(
                    width: 200,
                    height: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.blue[50],
                      elevation: 10,
                      // color: Colors.white,
                      // child: Text(tx.title, style: TextStyle(color: Colors.white),),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 2
                              ),                            
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('\$${transactions[0].amount.toStringAsFixed(2)}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // color: Colors.grey[700],
                              color: Colors.blue[600],
                              fontFamily: 'OpenSans'
                            ),)
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 18,),
                            Text(transactions[0].title, 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey[700],
                              color: Colors.blue[600],
                              fontFamily: 'OpenSans'
                            ),),
                            // Text(DateFormat.yMMMd().format(tx.date),
                            //   style: TextStyle(
                            //     color: Colors.black,
                            // ),),
                            SizedBox(
                              height: 13,
                            ),
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 200,
                              animation: true,
                              lineHeight:  15.0,
                              animationDuration: 1200,
                              percent: transactions[0].progress/100,
                              center: Text(transactions[0].progress.toString(), style: TextStyle(color: Colors.white,
                              fontFamily: 'OpenSans')),
                              // percent: 0.8,
                              // center: Text("80.0%", style: TextStyle(color: Colors.white,
                              // fontFamily: 'OpenSans')),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.blue,
                            ),
                          ],)
                        ],
                      ),
                    ),
                  )
                  ],));
  }
}