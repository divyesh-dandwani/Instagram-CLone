import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class searchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MySearchPageState();
}

class MySearchPageState extends State<searchPage> {
  final List<String> demoList = ["Memes", "Nature", "Wildlife", "Cricket", "Bollywood"];

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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  onTap: () {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: screenWidth * 0.005,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: screenWidth * 0.005,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11),
                height: 40,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              demoList[index],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: demoList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(top: 16.0), // Adjust this value to control the gap
            ),

            SliverFillRemaining(
              child: Stack(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemCount: 30, // Replace with your actual item count
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
                            "https://picsum.photos/id/${index + 1047}/500/500",
                            fit: BoxFit.cover, // Ensure images cover the container
                          ),
                        ),
                      );
                    },
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
                                      "https://picsum.photos/id/${_currentIndex + 1047}/500/500",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
