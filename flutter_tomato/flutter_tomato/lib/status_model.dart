import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StatusModel extends Model{
  final int _MAX_TIME = 1* 10;
//  final int _MAX_TIME = 15* 60;

  BuildContext _context;





  int _time ;

  bool _isRunning = false;




  get time => _time;

  get running => _isRunning;

  get maxTime => _MAX_TIME;


  StatusModel(){
    _time = maxTime;
  }


  setContext(BuildContext context){
    this._context = context;
    print("StatusModel set context");

  }



  void startRun(){
    _isRunning = true;
    notifyListeners();
    _timeDecrease();
  }

  void pauseRun(){
    _isRunning = false;
    notifyListeners();
  }

  void stopRun(){
    _isRunning = false;
    _time = _MAX_TIME;
    notifyListeners();
  }


  void _timeIncrease() async {
    while(_isRunning){
      await Future.delayed(Duration(seconds: 1));
      if(_isRunning){
        _time++;
      }
      notifyListeners();

      if(_time == _MAX_TIME){
        stopRun();
        Navigator.of(_context).pushNamed("task_finish");
        break;
      }
    }
  }


  void _timeDecrease() async {
    while(_isRunning){
      await Future.delayed(Duration(seconds: 1));
      if(_isRunning){
        _time--;
      }
      notifyListeners();

      if(_time == 0){
        stopRun();
        Navigator.of(_context).pushNamed("task_finish");
        break;
      }
    }
  }



}