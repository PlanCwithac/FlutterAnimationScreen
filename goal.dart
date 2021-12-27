import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Goal extends StatefulWidget {

  static SharedPreferences prefs;
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
  static String goalName='',goalDetails='';
  static DateTime firstDay=new DateTime.now();
  static DateTime nextDay=new DateTime.now();
  static var firstDaySave=firstDay.millisecondsSinceEpoch;



  @override
  _GoalState createState() => _GoalState();
}
TextEditingController _goalController=new TextEditingController();
TextEditingController _detailsController=new TextEditingController();
class _GoalState extends State<Goal> {


  String textName,data;
   Future<String>get _localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async{
    final path= await _localPath;
    return File('$path/$textName.txt');
  }
  Future<File> writeContent(String content) async{
    final file= await _localFile;
    print(file.path);
    return file.writeAsString(content);
  }
  Future<String> readcontent() async {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment(-0.4, -1.0),
              end: Alignment.bottomRight,
              colors: [
                Color(0xfffff300),
                Color(0xffab21f3),
              ],
              stops: [
                0,
                1,
              ],
            ),
            backgroundBlendMode: BlendMode.srcOver,
          ),

        child: SingleChildScrollView(
          child: Center(
            child:Column(
            children: [
              Padding(
                child: Text("Hedefini Belirle",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey[800]),),
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/5),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/25, MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.width/25, 0),
                  child: Text("Hedefine bir isim koy",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.grey[800]),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.width/25),
                child: TextField(
                  controller: _goalController,
                  cursorColor: Colors.white,
                  maxLength: 40,
                  decoration: InputDecoration(
                    prefixIcon:Icon(Icons.star_border,color: Colors.grey[800],) ,
                    hintText: 'Düzenli yürüyüş, sigarayı bırakmak...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/25, MediaQuery.of(context).size.width/10, MediaQuery.of(context).size.width/25, 0),
                  child: Text("Detayları yaz",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.grey[800]),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.width/25),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: _detailsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 300,
                  decoration: InputDecoration(

                    prefixIcon:Icon(Icons.event_note_outlined,color: Colors.grey[800],) ,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/1.45, MediaQuery.of(context).size.width/20, 0, 0),
                child: ButtonTheme(
                  height: 40,
                  child: FlatButton(
                    child: Text("Tamamla",style: TextStyle(color: Colors.pink[800]),),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.pink[900],
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.grey[350],
                    onPressed: ()async{
                      await Goal.init();
                      print(Goal.nextDay);
                      print(Goal.firstDay);
                      //final prefs=await SharedPreferences.getInstance();
                      Goal.prefs.setInt('firstDay', Goal.firstDaySave);
                      //SharedPreferences.setMockInitialValues({});
                      // final prefs=await SharedPreferences.getInstance();
                      // prefs.setInt('firstDay', Goal.firstDaySave);
                      textName='goal';
                      await writeContent(_goalController.text);
                      await readcontent().then((String value) => data=value);
                      Goal.goalName=data;
                      print(data);
                      textName='details';
                      await writeContent(_detailsController.text);
                      await readcontent().then((String value) => data=value);
                      Goal.goalDetails=data;
                      print(data);
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
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
