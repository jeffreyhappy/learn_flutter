import 'package:scoped_model/scoped_model.dart';

class StatusModel extends Model{
  int _time = 0;

  bool _isRunning = false;

  get time => _time;

  get running => _isRunning;

  void _timeIncrease() async {
    while(_isRunning){
      await Future.delayed(Duration(seconds: 1));
      if(_isRunning){
        _time++;
      }
      notifyListeners();
    }
  }

  void startRun(){
    _isRunning = true;
    notifyListeners();
    _timeIncrease();
  }

  void pauseRun(){
    _isRunning = false;
    notifyListeners();
  }

  void stopRun(){
    _isRunning = false;
    _time = 0;
    notifyListeners();
  }




}