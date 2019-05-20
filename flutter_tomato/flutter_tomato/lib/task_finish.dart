
import 'package:flutter/material.dart';
import 'package:flutter_tomato/database_helper.dart';

class TaskFinishWidget extends StatelessWidget{
  String strDesc;

  void _textFieldChanged(String str){
    strDesc = str;
    print(str);
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
          title: Text("完成")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text("一次任务完成"),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 40,right: 40),
              child: TextField(
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  labelText: "完成一次任务,记录一下吧",
//                helperText: "写下你这次任务干了啥"
                ),
                onChanged:_textFieldChanged ,
              ),
            ),

            SizedBox(height: 10),
            RaisedButton(
              onPressed: (){
                DbHelper dbHelper = DbHelper();
                dbHelper.insert(strDesc);
                Navigator.pop(context);
              },
              color: Colors.blue,
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              child: Text(
                  "确定",
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

}