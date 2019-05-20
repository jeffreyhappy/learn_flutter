

class TomatoTask{
  int     _id;
  String  _task_desc;
  int  _time;

  get id => _id;
  get taskDesc => _task_desc;
  get time => _time;


  TomatoTask.fromMap(Map<String,dynamic> map){
    _id = map["id"];
    _task_desc = map["task_desc"];
    _time = map["finish_time"];
  }
}