import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Homepage extends StatefulWidget {


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String textName='1',data;
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
      body: FutureBuilder(
        future: readcontent(),

        builder:(_,snapshot){
          if(snapshot.hasData){
            print(snapshot.data.toString());
            textName=(int.parse(textName)+1).toString();
            print(textName);
            return Row(
              children: [
                Center(
                  child: Container(
                    child: Text(snapshot.data.toString(),style: TextStyle(color: Colors.black),),
                  ),
                ),
                Center(
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ),
              ],
            );
          }
          else
            return Text('hi');
      },

      ),
    );
  }
}
