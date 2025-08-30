import 'package:demo_1/bottomNavigationBar.dart';
import 'package:demo_1/insta_homepage.dart';
import 'package:demo_1/main.dart';
import 'package:demo_1/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyLoginPage();
}

class MyLoginPage extends State<LoginPage>{
  var finalUsername = "";
  var finalPassword = "";
  var this_username = TextEditingController();
  var this_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Center(child: Text("Instagram")),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: screenWidth * 0.015,
                  ),
                ),
                child: CircleAvatar(
                    child: Icon(Icons.account_circle),
                    radius: screenWidth * 0.2,
                    foregroundImage: AssetImage('assets/images/Wallpaper.jpeg')
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              SizedBox(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: this_username,
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
                    prefixIcon: Icon(Icons.account_circle),
                    label: Text("Enter your Username"),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              SizedBox(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: this_password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                      label: (Text("Enter your Password")),
                      prefixIcon: Icon(Icons.lock)
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.07),

              ElevatedButton(onPressed: () async{
                var this_login_user = this_username.text.toString();
                var this_login_pass = this_password.text.toString();
                var sharedPref = await SharedPreferences.getInstance();
                var u_name = sharedPref.getString("user_name");
                var pass_word = sharedPref.getString("pass_word");
                finalUsername = u_name.toString();
                finalPassword = pass_word.toString();
                sharedPref.setBool(HomePage.keyLogin, true);
                if((finalUsername == this_login_user) && (finalPassword == this_login_pass)){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => bottomNavigationBar()
                      )
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Username OR Password...")));
                }
              }, child: Text("Log In",style: TextStyle(fontSize: 40,color: Colors.black)),
                style: ElevatedButton.styleFrom(
                    elevation: 15.0,
                    backgroundColor: Colors.blue
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  InkWell(onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUp()
                        ));
                  },child: Text("Sign Up",style: TextStyle(color: Colors.blue)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}