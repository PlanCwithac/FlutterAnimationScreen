import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'animation.dart';
import 'goal.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

TextEditingController _detailsController=new TextEditingController();
class _HomeState extends State<Home> {
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



  int daysBetween(DateTime from,DateTime to){

    from=DateTime(from.year,from.month,from.day);
    to=DateTime(to.year,to.month,to.day);
    return (to.difference(from).inHours/24).round();
  }
  getPrefs()async{

    int timeStamp=Goal.prefs.getInt('firstDay');

    DateTime time=DateTime.fromMillisecondsSinceEpoch(timeStamp);

    return time;
  }
  Future calculateDay()async{
    await Goal.init();

    DateTime time=await getPrefs();
    return daysBetween(time, Goal.nextDay)+1;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:FutureBuilder(
          future: calculateDay(),
          builder: (_,snapshot){
            if(snapshot.hasData){
              textName=snapshot.data.toString();

              return Text(snapshot.data.toString());
            }
            else
              return Text('0');
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Text(Goal.goalDetails),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Reset'),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/goal');
                },
              ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text('Send'),
                  onPressed: ()async{
                    await writeContent(_detailsController.text);
                    await readcontent().then((String value) => data=value);
                    print(textName);
                    print(data);
                    Navigator.of(context).pushReplacementNamed('/page');
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/page');
                  },
                ),

              ),


            ],
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
        ],
      ),
    );
  }
}
