import 'dart:async';
import 'dart:math';
import 'package:demo_1/messanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstaHomepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyInstaHomePage();
}

class MyInstaHomePage extends State<InstaHomepage> {
  List<Map<String, dynamic>> dummyData = [
    {"location": "Paris, USA", "post": "assets/images/image_1.jpg", "likes":  _generateRandomNumber(10, 10000), "comments": "50", "days": "10","liked": false,"iconVisible": false,},
    {"location": "Las Vegas, USA", "post": "assets/images/image_2.jpeg", "likes": _generateRandomNumber(10, 10000), "comments": "180", "days": "50","liked": false,"iconVisible": false,},
    {"location": "Los Angeles, USA", "post": "assets/images/image_3.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "100", "days": "30","liked": false,"iconVisible": false,},
    {"location": "Darjeeling, India", "post": "assets/images/image_4.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "1.8K", "days": "80","liked": false,"iconVisible": false,},
    {"location": "New York, USA", "post": "assets/images/image_5.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "800", "days": "45","liked": false,"iconVisible": false,},
    {"location": "Motera Stadium", "post": "assets/images/image_6.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "888", "days": "70","liked": false,"iconVisible": false,},
    {"location": "PVR Cinema, Gandhinagar", "post": "assets/images/image_7.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "1K", "days": "65","liked": false,"iconVisible": false,},
    {"location": "Urban Chowk, Bhatt", "post": "assets/images/image_8.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "10.3K", "days": "58","liked": false,"iconVisible": false,},
    {"location": "Gift City, Gandhinagar", "post": "assets/images/image_9.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "3.3K", "days": "22","liked": false,"iconVisible": false,},
    {"location": "Udaipur, India", "post": "assets/images/image_10.jpg", "likes": _generateRandomNumber(10, 10000), "comments": "90", "days": "27","liked": false,"iconVisible": false,},
  ];

  static int _generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  void _showIconForDuration(int index) {
    setState(() {
      dummyData[index]['iconVisible'] = true; // Show the icon for the specific post
    });

    // Hide the icon after 1 seconds (or adjust as needed)
    Timer(Duration(seconds: 1), () {
      setState(() {
        dummyData[index]['iconVisible'] = false; // Hide the icon for the specific post
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Instagram", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Messanger()),
              );
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: screenHeight * 0.015),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.orange, Colors.yellow],
                              ),
                              border: Border.all(width: 4, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage("https://picsum.photos/id/${index + 1047}/800/1080"),
                                radius: 32,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Username",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: screenHeight * 0.015),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.002,
              color: Colors.grey,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: screenHeight * 0.01),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    int _randomNumber = _generateRandomNumber(1000, 1100);
                final data = dummyData[index];
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(backgroundImage: AssetImage('assets/images/Wallpaper.jpeg')),
                        title: Text("Username", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${data['location']}"),
                        trailing: Icon(Icons.more_horiz),
                      ),
                      InkWell(
                        onDoubleTap: () {
                          setState(() {
                            if (!data['liked']) {
                              data['likes'] = (data['likes'] as int) + 1;
                              data['liked'] = true; // Update the flag
                              _showIconForDuration(index); // Show the temporary icon for the specific post
                            }
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('${data['post']}'),
                            if (data['iconVisible'] as bool) // Show the icon if the flag is true
                              Icon(
                                Icons.favorite,
                                color: Colors.grey.shade200,
                                size: 100, // Adjust size as needed
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: screenWidth * 0.02),
                          IconButton(
                            icon: Icon(
                              data['liked'] ? Icons.favorite : Icons.favorite_border,
                              color: data['liked'] ? Colors.pink : Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                if (!data['liked']) {
                                  data['likes'] = (data['likes'] as int) + 1;
                                  data['liked'] = true;
                                } else{
                                  data['likes'] = (data['likes'] as int) - 1;
                                  data['liked'] = false;
                                }
                              });
                            },
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Icon(Icons.chat_bubble_outline,size: 30),
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Expanded(
                            child: Icon(Icons.send,size: 30),
                          ),
                          SizedBox(width: screenWidth * 0.4),
                          Expanded(
                            child: Icon(Icons.bookmark_border_outlined,size: 30),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.008),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data['likes']} Likes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                text: "Username",
                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: " Caption",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("View all ${data['comments']} comments"),
                            SizedBox(height: 5),
                            Text("${data['days']} days ago"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: dummyData.length,
            ),
          ),
        ],
      ),
    );
  }
}
