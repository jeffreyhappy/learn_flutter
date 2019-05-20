import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tomato/database_helper.dart';
import 'package:flutter_tomato/status_model.dart';
import 'package:flutter_tomato/tomato_task.dart';
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




  @override
  Widget build(BuildContext context) {

    StatusModel statusModel =  ScopedModel.of<StatusModel>(context,rebuildOnChange: true);
//    if(statusModel.taskFinish){
//      Navigator.of(context).pushNamed("task_finish");
//    }
    statusModel.setContext(context);
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

  @override
  void initState() {
    super.initState();
    DbHelper dbHelper = DbHelper();
    dbHelper.getList().then((List<TomatoTask> datas){
      for(int i = 0 ; i < datas.length ; i++){
        print("dbHelper " + datas[i].time.toString() + " " + datas[i].id.toString() + " " + datas[i].taskDesc );
        int time = datas[i].time;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
        print("time " + time.toString() + " is " + dateTime.year.toString() + " " + dateTime.month.toString() + " " + dateTime.day.toString() + " ");
      }
    });
  }

//  onListResult(List<TomatoTask> datas){
//
//  }


//  Future<void> _showTaskFinish(BuildContext context) async {
//    switch (await showDialog<bool>(
//        context: context,
//        builder: (BuildContext context) {
//          return SimpleDialog(
//            title: const Text('一个任务完成啦'),
//            children: <Widget>[
//              SimpleDialogOption(
//                onPressed: () { Navigator.pop(context, false); },
//                child: const Text('取消'),
//              ),
//              SimpleDialogOption(
//                onPressed: () { Navigator.pop(context, true); },
//                child: const Text('确认'),
//              ),
//            ],
//          );
//        }
//    )) {
//      case false:
//      // Let's go.
//      // ...
//        print("click cancel");
//        break;
//      case true:
//      // ...
//        print("click ok");
//        break;
//    }
//  }
}


class TimeTextWidget extends StatelessWidget{
  int _time;
  TimeTextWidget(this._time);

  String formatTime(int _time){
    double minute = _time / 60;
    int second = _time % 60;
    String strMinute = minute.toInt().toString();
    if(strMinute.length == 1){
      strMinute = "0" + strMinute;
    }
    String strSecond = second.toInt().toString();
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



  @override
  State<StatefulWidget> createState() {
    return new ControllerState();
  }
}

class ControllerState extends State<ControllerLayout> {



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
