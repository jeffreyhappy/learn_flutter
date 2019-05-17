import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tomato/status_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyHomeTomatoPage extends StatefulWidget {
  MyHomeTomatoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomeTomatoPageState createState() => _MyHomeTomatoPageState();
}

class _MyHomeTomatoPageState extends State<MyHomeTomatoPage> {
  final int MAX_TIME = 1* 60;
//  int _time = 0;
//  bool isRunning = false;
//  void _timeIncrease() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _time++;
//    });
//    if(_time >= MAX_TIME){
//      _pause();
//    }
//  }
//
//  void _start(){
//    setState(() {
//      isRunning = true;
//    });
//    asyncAwait();
//  }
//
//  void _stop(){
//    setState(() {
//      isRunning = false;
//      _time = 0;
//    });
//  }
//
//
//  void _pause(){
//    setState(() {
//      isRunning = false;
//    });
//  }

//  Future<void> asyncAwait() async{
//    try{
//      while(isRunning){
//        await Future.delayed(Duration(seconds: 1));
//        if(isRunning){
//          _timeIncrease();
//
//        }
//      }
//    }catch(e){
//      print('failed: ${e.toString()}');
//    }
//  }



  @override
  Widget build(BuildContext context) {

//    return ScopedModelDescendant<StatusModel>(
//      builder: (context,child,model){},
//    );
    StatusModel statusModel =  ScopedModel.of<StatusModel>(context,rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TimeTextWidget(statusModel.time),
            const SizedBox(height: 30),
            ControllerLayout()
          ],
        ),
      ),
    );
  }
}


class TimeTextWidget extends StatelessWidget{
  int _time;
  TimeTextWidget(this._time);

  String formatTime(int _time){
    double minute = _time / 60;
    int second = _time % 60;
    String strMinute = minute.toStringAsFixed(0);
    if(strMinute.length == 1){
      strMinute = "0" + strMinute;
    }
    String strSecond = second.toString();
    if(strSecond.length == 1){
      strSecond = "0" + strSecond;
    }
    return strMinute + ":" + strSecond;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(_time),
      style: TextStyle(fontSize: 40, color: Colors.black54),
    );
  }

}

class ControllerLayout extends StatefulWidget {
//  Function onClickStart;
//  Function onClickStop;
//
//  Function  onClickPause;
//
//
//  ControllerLayout(this.onClickStart,this.onClickStop,this.onClickPause);


  @override
  State<StatefulWidget> createState() {
    return new ControllerState();
  }
}

class ControllerState extends State<ControllerLayout> {

//  Function  onClickStart;
//  Function  onClickStop;
//  Function  onClickPause;
//
//  bool isRunning = false;


//  ControllerState();

  @override
  Widget build(BuildContext context) {

    StatusModel statusModel =  ScopedModel.of<StatusModel>(context,rebuildOnChange: true);

    print("ControllerState build " +statusModel.running.toString());
    Widget leftButton;
    if (statusModel.running){
      leftButton =  RaisedButton(
        onPressed: (){

          statusModel.pauseRun();
        },
        color: Colors.red,
        child: Text(
          "暂停",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );


    }else{
      leftButton =  RaisedButton(
        onPressed: (){
          statusModel.startRun();
        },
        color: Colors.lightBlue,
        child: Text(
          "开始",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        leftButton,
        RaisedButton(
          onPressed: () {
            statusModel.stopRun();
          },
          color: Colors.red[200],
          child: Text(
            "重置",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }
}
