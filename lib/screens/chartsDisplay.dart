import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
class ChartsDisplay extends StatefulWidget {
  final Widget child;
  ChartsDisplay({Key key, this.child}) : super(key: key);
  _ChartsDisplayState createState() => _ChartsDisplayState();
}
class _ChartsDisplayState extends State<ChartsDisplay> {
  List<charts.Series<AlcoholLtrs, String>> _seriesData;
  List<charts.Series<Money, String>> _seriesxData;
  List<charts.Series<Routine, int>> _seriesLineData;
  List<charts.Series<Weight, int>> _seriesLinesData;
  _generateData() {
    var data1 = [
      new AlcoholLtrs( 'Day1', 9),
      new AlcoholLtrs( 'Day2', 5),
      new AlcoholLtrs( 'Day3', 6),
      new AlcoholLtrs( 'Day4', 6),
      new AlcoholLtrs( 'Day5', 8),
      new AlcoholLtrs( 'Day6', 4),
      new AlcoholLtrs( 'Day7', 4),
    ];
    var data2 = [
      new AlcoholLtrs( 'Day1', 8),
      new AlcoholLtrs( 'Day2', 10),
      new AlcoholLtrs( 'Day3', 3),
      new AlcoholLtrs( 'Day4', 7),
      new AlcoholLtrs( 'Day5', 5),
      new AlcoholLtrs( 'Day6', 3),
      new AlcoholLtrs( 'Day7', 8),
    ];
    var datas = [
      new Money( 'Day1', 3),
      new Money( 'Day2', 100),
      new Money( 'Day3', 96),
      new Money( 'Day4', 44),
      new Money( 'Day5', 88),
      new Money( 'Day6', 25),
      new Money( 'Day7', 19),
    ];
    var linerotdata = [
      new Routine(1, 10),
      new Routine(2, 1),
      new Routine(3, 12),
      new Routine(4, 12),
      new Routine(5, 0),
      new Routine(6, 4),
      new Routine(7, 4),
    ];
    var linerotdata1 = [
      new Routine(1, -9),
      new Routine(2, 0),
      new Routine(3, -11),
      new Routine(4, -11),
      new Routine(5, 3),
      new Routine(6, -2),
      new Routine(7, -2),
    ];
    var tempfline = [
      new Weight(1, 62),
      new Weight(2, 60),
      new Weight(3, 61),
      new Weight(4, 59),
      new Weight(5, 59),
      new Weight(6, 60),
      new Weight(7, 60),
    ];
    _seriesData.add(
      charts.Series(
        domainFn: (AlcoholLtrs alc, _) => alc.day,
        measureFn: (AlcoholLtrs alc, _) => alc.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (AlcoholLtrs alc, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff981047)),
      ),
    );
    _seriesData.add(
      charts.Series(
        domainFn: (AlcoholLtrs alc, _) => alc.day,
        measureFn: (AlcoholLtrs alc, _) => alc.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (AlcoholLtrs alc, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );
    _seriesxData.add(
      charts.Series(
        domainFn: (Money mon, _) => mon.day,
        measureFn: (Money mon, _) => mon.dol,
        id: 'sample',
        data: datas,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Money mon, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff1976d2)),
      ),
    );
    _seriesLineData.add(
      charts.Series(
        domainFn: (Routine rot, _) => rot.day,
        measureFn: (Routine rot, _) => rot.hours,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Daily Alcohol Consumption',
        data: linerotdata,

      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff679434)),
        id: 'Daily Alcohol Consumption',
        data: linerotdata1,
        domainFn: (Routine rot, _) => rot.day,
        measureFn: (Routine rot, _) => rot.hours,
      ),
    );
    _seriesLinesData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff1976d2)),
        id: 'Daily Alcohol Consumption',
        domainFn: (Weight weight, _) => weight.day,
        measureFn: (Weight weight, _) => weight.w,
        data: tempfline,
      ),
    );

  }
  @override
  void initState() {
    super.initState();
    _seriesData = List<charts.Series<AlcoholLtrs, String>>();
    _seriesxData = List<charts.Series<Money, String>>();
    _seriesLineData = List<charts.Series<Routine, int>>();
    _seriesLinesData = List<charts.Series<Weight, int>>();
    _generateData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: DefaultTabController(
        length: 4,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.cyanAccent[400],Colors.blue[600]],
        )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: GradientAppBar(
              // backgroundColor: Color(0xff1976d2),
              backgroundColorStart: Colors.blue[600],
    backgroundColorEnd: Colors.cyan,
              //backgroundColor: Color(0xff308e1c),
              bottom: TabBar(
                indicatorColor: Colors.red[800],
                tabs: [
                  Tab(
                    icon: Icon(FontAwesomeIcons.solidChartBar),
                  ),
                  Tab(icon: Icon(FontAwesomeIcons.solidChartBar)),
                  Tab(icon: Icon(FontAwesomeIcons.chartLine)),
                  Tab(icon: Icon(FontAwesomeIcons.chartLine)),
                ],
              ),
              title: Text('Progress Trends'),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Daily Alcohol Consumption (Ltrs): You vs The Others',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                          Expanded(
                            child: charts.BarChart(
                              _seriesData,
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
                              //behaviors: [new charts.SeriesLegend()],
                              animationDuration: Duration(seconds: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Money Spent on Alcohol',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10.0,),
                          Expanded(
                            child: charts.BarChart(
                                _seriesxData,
                                animate: true,
                                animationDuration: Duration(seconds: 3),

                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Your Sleep vs Exercise Pattern',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                          Expanded(
                            child: charts.LineChart(
                                _seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 3),
                                behaviors: [
                                  new charts.ChartTitle('Days',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Hours',
                                      behaviorPosition: charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Your Weight Variations',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                          Expanded(
                            child: charts.LineChart(
                                _seriesLinesData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 3),
                                behaviors: [
                                  new charts.ChartTitle('Days',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Weight',
                                      behaviorPosition: charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlcoholLtrs {
  String day;
  int quantity;
  AlcoholLtrs(this.day, this.quantity);
}

class Money {
  String day;
  double dol;
  Money(this.day, this.dol);
}

class Routine {
  int day;
  int hours;
  Routine(this.day, this.hours);
}

class Weight {
  int day;
  int w;
  Weight(this.day, this.w);
}