import 'package:demo_1/insta_homepage.dart';
import 'package:demo_1/post_page.dart';
import 'package:demo_1/profile.dart';
import 'package:demo_1/reel_page.dart';
import 'package:demo_1/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyBNB();
}

class MyBNB extends State<bottomNavigationBar>{
  var selectedIndex;
  int myIndex = 0;
  var screen_list = [
    InstaHomepage(),
    searchPage(),
    postPage(),
    reelPage(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_list[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: selectedIndex == 3 ? Colors.black : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index){
          selectedIndex = index;
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                  size: 30
              ), label: ''),

          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 1 ? Icons.search : Icons.search_outlined,
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                  size: 30
              ),label: ''),

          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? Icons.add_box : Icons.add_box_outlined,
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                  size: 30
              ),label: ''),

          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3 ? Icons.play_circle : Icons.play_circle_outline,
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                  size: 30
              ),label: ''),

          BottomNavigationBarItem(
              icon: Icon(
                  Icons.account_circle,
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                  size: 30
              ),label: ''),
        ],
      ),
    );
  }

}