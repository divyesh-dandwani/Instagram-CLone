import 'dart:async';
import 'package:demo_1/bottomNavigationBar.dart';
import 'package:demo_1/login_page.dart';
import 'package:demo_1/reel_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontSize: 51)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => HomePage();
}

class HomePage extends State<MyHomePage>{
  static const String keyLogin = "login";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: FaIcon(FontAwesomeIcons.instagram,color: Colors.pink,size: 200),
          ),
        )
    );
  }
  void loginPage() async{
    var sharedPref = await SharedPreferences.getInstance();
    var checkLogIn = sharedPref.getBool(keyLogin);

    Timer(Duration(seconds: 2),(){
      if(checkLogIn!=null){
        if(checkLogIn){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => bottomNavigationBar()));
        }
        else{
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
      else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
  });
}
}