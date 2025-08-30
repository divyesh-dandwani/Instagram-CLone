import 'package:demo_1/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class newPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _newPassword();

}

class _newPassword extends State<newPassword>{
  var new_password = TextEditingController();
  var confirm_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Password",style: TextStyle(fontSize: screenWidth * 0.08)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Container(
            height: screenHeight * 0.9,
            width: screenWidth * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.3,top: screenHeight * 0.05),
                  child: Text("Enter New Password",style: TextStyle(fontSize: screenWidth * 0.05),),
                ),

                Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05,top: screenHeight * 0.02),
                    child: TextField(
                      controller: new_password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                        prefixIcon: Icon(Icons.lock_clock_outlined),
                        label: Text("New Password"),
                      ),
                    )
                ),

                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.23,top: screenHeight * 0.05),
                  child: Text("Confirm New Password",style: TextStyle(fontSize: screenWidth * 0.05),),
                ),

                Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05,top: screenHeight * 0.02),
                    child: TextField(
                      controller: confirm_password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                        prefixIcon: Icon(Icons.lock_clock_outlined),
                        label: Text("Confirm Password"),
                      ),
                    )
                ),

                SizedBox(height: screenHeight * 0.3),

                ElevatedButton(onPressed: () async{
                  var new_passWord = new_password.text.toString();
                  var confirm_passWord = confirm_password.text.toString();
                  var sharedPref = await SharedPreferences.getInstance();

                  if(new_passWord == confirm_passWord){
                    sharedPref.setString("pass_word", new_passWord);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => bottomNavigationBar()
                        )
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Both are different...")));
                  }
                }, child: Text("Change Password",style: TextStyle(fontSize: 30,color: Colors.black)),
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