import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Messanger extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MessangerChat();
}

class MessangerChat extends State<Messanger>{
  var userName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(userName,style: TextStyle(fontSize: screenWidth * 0.08,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.account_circle,size: screenWidth * 0.08),
          title: Text("@Username",style: TextStyle(fontSize: screenWidth * 0.04)),
          subtitle: Text("4+ new messages",style: TextStyle(fontSize: screenWidth * 0.04)),
          trailing: Icon(Icons.messenger),
        );
        },
        itemCount: 20,
        separatorBuilder: (context,index){
        return Divider(height: screenHeight * 0.01,thickness: screenHeight * 0.005);
        },
      )
    );
  }

  void getUsername() async{
    var SharedPref = await SharedPreferences.getInstance();
    var user_name = SharedPref.getString("user_name");
    userName = user_name.toString();
    setState(() {

    });
  }
}