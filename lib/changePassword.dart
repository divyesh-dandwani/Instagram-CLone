import 'package:demo_1/newPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChangePassword();

}

class _ChangePassword extends State<ChangePassword>{
  var passWord = TextEditingController();
  var old_password = "";
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password",style: TextStyle(fontSize: screenWidth * 0.08)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight * 0.9,
          width: screenWidth * 0.9,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.22,top: screenHeight * 0.05),
                child: Text("Enter your Old Password",style: TextStyle(fontSize: screenWidth * 0.05),),
              ),

              Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05,top: screenHeight * 0.02),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passWord,
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
                      label: Text("Password"),
                    ),
                  )
              ),

              SizedBox(height: screenHeight * 0.5),

              ElevatedButton(onPressed: () async{
                var password = passWord.text.toString();
                var sharedPref = await SharedPreferences.getInstance();
                var pass_word = sharedPref.getString("pass_word");
                old_password = pass_word.toString();

                if(password == old_password){
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => newPassword()
                      )
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Password...")));
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