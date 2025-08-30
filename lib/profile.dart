import 'dart:ui';
import 'package:demo_1/changePassword.dart';
import 'package:demo_1/edit_profile.dart';
import 'package:demo_1/login_page.dart';
import 'package:demo_1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyProfile();
}

class MyProfile extends State<Profile>{
  var userName = "";
  var fullName = "";

  bool _isDialogVisible = false;
  late int _currentIndex;

  void _showDialog(int index) {
    setState(() {
      _isDialogVisible = true;
      _currentIndex = index;
    });
  }

  void _hideDialog() {
    setState(() {
      _isDialogVisible = false;
    });
  }

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
        title: Text(userName,style: TextStyle(fontSize: screenWidth * 0.07,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: screenHeight * 0.13,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                  ),
                  child: Text("Instagram",style: TextStyle(color:  Colors.black,fontSize: 30))
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){},
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.heart),
              title: Text("Liked Video"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text("Saved Videos"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.more_time_sharp),
              title: Text("Archieve"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Recently Deleted"),
              onTap: (){},
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.lock),
              title: Text("Change Password"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword())
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: (){
                showDialog(context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Log Out ? "),
                      contentPadding: EdgeInsets.all(10.0),
                      content: Text("Are you sure ? "),
                      actions: [
                        TextButton(onPressed: () async{
                          var SharedPref = await SharedPreferences.getInstance();
                          SharedPref.setBool(HomePage.keyLogin, false);
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LoginPage())
                          );
                        }, child: Text("Log Out")
                        ),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Cancel")
                        ),
                      ],
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.05),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Wallpaper.jpeg'),
                      radius: screenWidth * 0.1,
                    ),

                    Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue
                          ),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add),
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(width: screenWidth * 0.12),
                Column(
                  children: [
                    Text("18",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold)),
                    Text("Posts",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(width: screenWidth * 0.06),
                Column(
                  children: [
                    Text("230",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold)),
                    Text("Followers",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  children: [
                    Text("200",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold)),
                    Text("Following",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
                children: [
                  SizedBox(width: screenWidth * 0.03),
                  Text(fullName,style: TextStyle(fontSize: screenWidth * 0.07,fontWeight: FontWeight.bold)),
                ]
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => edit_profile())
                      );
                    },
                    child: Container(
                      height: screenHeight * 0.03,
                      width: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Center(child:  Text("Edit Profile",style: TextStyle(fontSize: 15))),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: screenHeight * 0.03,
                      width: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Center(child:  Text("Share Profile",style: TextStyle(fontSize: 15))),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: screenHeight * 0.03,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Center(child: Icon(Icons.people)),
                    ),
                  ),
                ]
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.05),
                InkWell(
                  child: CircleAvatar(backgroundImage: AssetImage('assets/images/Plus.png'),radius: screenWidth * 0.06),
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No stories have been posted yet...")));
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
              width: double.infinity,
              height: screenHeight * 0.002,
              color: Colors.grey,
            ),
            SizedBox(height: screenHeight * 0.005),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.1),
                Icon(Icons.post_add,size: screenWidth * 0.09),
                SizedBox(width: screenWidth * 0.14),
                Container(width: screenWidth * 0.003,height: screenHeight * 0.05,color: Colors.grey),
                SizedBox(width: screenWidth * 0.125),
                Icon(Icons.play_circle_outline,size: screenWidth * 0.09),
                SizedBox(width: screenWidth * 0.115),
                Container(width: screenWidth * 0.003,height: screenHeight * 0.05,color: Colors.grey),
                SizedBox(width: screenWidth * 0.14),
                FaIcon(FontAwesomeIcons.userTag,size: screenWidth * 0.05)
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
            Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.47, // Adjust the height according to your needs
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: 18, // Replace with your actual item count
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPressStart: (details) {
                          // Show the dialog when the long press starts
                          _showDialog(index);
                        },
                        onLongPressEnd: (details) {
                          // Hide the dialog when the long press ends
                          _hideDialog();
                        },
                        child: Container(
                          child: Image.network(
                            "https://picsum.photos/id/${index + 1065}/500/500",
                            fit: BoxFit.cover, // Ensure images cover the container
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_isDialogVisible)
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 50.0,
                    child: GestureDetector(
                      onTap: () => _hideDialog(),
                      child: Container(
                        color: Colors.black.withOpacity(0.5), // Dim the background
                        child: Center(
                          child: Material(
                            elevation: 0, // Remove shadow
                            color: Colors.transparent, // Make background transparent
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur amount
                                    child: Container(
                                      color: Colors.black.withOpacity(0), // Transparent background to show the blur
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Image.network(
                                    "https://picsum.photos/id/${_currentIndex + 1065}/500/500",
                                    fit: BoxFit.cover,
                                    height: double.infinity, // Adjust size as needed
                                    width: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      )
    );
  }

  void getUsername() async{
    var SharedPref = await SharedPreferences.getInstance();
    var u_name = SharedPref.getString("user_name");
    var f_name = SharedPref.getString("full_name");
    userName = u_name.toString();
    fullName = f_name.toString();
    setState(() {

    });
  }

}