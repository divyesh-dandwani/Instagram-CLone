import 'package:demo_1/bottomNavigationBar.dart';
import 'package:demo_1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class username_and_profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyUsernameProfile();
}

class MyUsernameProfile extends State<username_and_profile>{
  var username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              CircleAvatar(
                child: Icon(Icons.account_circle,size: screenWidth * 0.35),
                radius: screenWidth * 0.22,
                // foregroundImage: AssetImage('assets/images/Wallpaper.jpeg'),
              ),
              SizedBox(height: screenHeight * 0.15),
              Text("Enter your Username : ",style: TextStyle(fontSize: screenWidth * 0.07,fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.9,
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(11)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(11)
                    ),
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    label: Text("Username"),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(onPressed: () async {
                var u_name = username.text.toString();
                var SharedPref = await SharedPreferences.getInstance();
                SharedPref.setString("user_name", u_name);
                SharedPref.setBool(HomePage.keyLogin, true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => bottomNavigationBar())
                );
              }, child: Text("Continue",style: TextStyle(fontSize: 50,color: Colors.black)),
                style: ElevatedButton.styleFrom(
                    elevation: 15.0,
                    backgroundColor: Colors.blue
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}