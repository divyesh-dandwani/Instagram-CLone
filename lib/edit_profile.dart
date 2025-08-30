import 'package:demo_1/bottomNavigationBar.dart';
import 'package:demo_1/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class edit_profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyEditProfile();
}

class MyEditProfile extends State<edit_profile>{
  var fullName = TextEditingController();
  var userName = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUserName();
  // }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(fontSize: screenWidth * 0.08,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03,width: screenWidth * 0.9),

            CircleAvatar(
              foregroundImage: AssetImage('assets/images/Wallpaper.jpeg'),
              radius: screenWidth * 0.2,
            ),

            SizedBox(height: screenHeight * 0.03),

            Text("Change Profile",style: TextStyle(fontSize: screenWidth * 0.08,color: Colors.blue)),

            SizedBox(height: screenHeight * 0.03),

            Container(
              height: screenHeight * 0.35,
              width: screenWidth * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name",style: TextStyle(fontSize: screenWidth * 0.05)),

                    TextField(
                      controller: fullName,
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    Text("Username",style: TextStyle(fontSize: screenWidth * 0.05)),

                    TextField(
                      controller: userName,
                    ),
                  ],
                ),
              )
            ),

            SizedBox(height: screenHeight * 0.01),

            ElevatedButton(onPressed: () async{
              var f_name = fullName.text.toString();
              var u_name = userName.text.toString();
              var SharedPref = await SharedPreferences.getInstance();
              SharedPref.setString("full_name", f_name);
              SharedPref.setString("user_name", u_name);
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => bottomNavigationBar())
              );
            }, child: Text("Change",style: TextStyle(fontSize: 40,color: Colors.black)),
              style: ElevatedButton.styleFrom(
                  elevation: 15.0,
                  backgroundColor: Colors.blue
              ),
            ),
          ],
        ),
      )
    );
  }

  // void getUserName() async {
  //   var SharedPref = await SharedPreferences.getInstance();
  //   var f_name = SharedPref.getString("full_name");
  //   var u_name = SharedPref.getString("user_name");
  //   fullName = f_name.toString();
  //   userName = u_name.toString();
  // }

}