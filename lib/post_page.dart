import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class postPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyPostPage();
}

class MyPostPage extends State<postPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title : Text("Instagram",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      ),
    );
  }

}