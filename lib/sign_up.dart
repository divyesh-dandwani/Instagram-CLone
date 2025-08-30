import 'package:demo_1/login_page.dart';
import 'package:demo_1/username_and_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MySignUp();
}

class MySignUp extends State<SignUp>{
  var name = TextEditingController();
  var password = TextEditingController();
  var password_2 = TextEditingController();
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
          child: Container(
            height: screenHeight * 0.9,
            width: screenWidth * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.instagram,size: screenWidth * 0.2,color: Colors.pink),
                    SizedBox(width: screenWidth * 0.03),
                    Text("Instagram",style: TextStyle(fontSize: screenWidth * 0.1,color: Colors.pink))
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                TextField(
                  controller: name,
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
                    label: Text("Enter your Full Name"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  keyboardType: TextInputType.phone,
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
                    prefixIcon: Icon(Icons.call),
                    label: Text("Enter your Phone Number"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                    prefixIcon: Icon(Icons.mail),
                    label: Text("Enter your Mail-Id"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  controller: password,
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
                    prefixIcon: Icon(Icons.lock),
                    label: Text("Enter your Password"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  controller: password_2,
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
                    prefixIcon: Icon(Icons.done_all),
                    label: Text("Re-enter your password"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(onPressed: () async{
                  var f_name = name.text.toString();
                  var pass = password.text.toString();
                  var pass_2 = password_2.text.toString();
                  var SharedPref = await SharedPreferences.getInstance();
                  SharedPref.setString("full_name", f_name);
                  SharedPref.setString("pass_word", pass);
                  // SharedPref.setBool(HomePage.keyLogin, true);
                  if(pass == pass_2){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => username_and_profile()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password must be same...")));
                  }
                },
                  child: Text("Create an Account",style: TextStyle(fontSize: 30,color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      elevation: 15.0,
                      backgroundColor: Colors.blue
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account ? "),
                    InkWell(onTap: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()
                          ));
                    },child: Text("Sign In",style: TextStyle(color: Colors.blue)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}