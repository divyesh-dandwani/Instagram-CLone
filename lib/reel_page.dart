import 'dart:async';
import 'dart:math';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class reelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyReelPage();
}

class MyReelPage extends State<reelPage> {
  List<Map<String, dynamic>> dummyData = [
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4", "likes":  _generateRandomNumber(10, 10000), "comments": "100", "days": "10","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "280", "days": "50","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "350", "days": "30","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "1.8K", "days": "80","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "800", "days": "45","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "888", "days": "70","liked": false,"iconVisible": false,},
    {"reel": "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4", "likes": _generateRandomNumber(10, 10000), "comments": "3.3K", "days": "65","liked": false,"iconVisible": false,},
  ];

  static int _generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  void _showIconForDuration(int index) {
    setState(() {
      dummyData[index]['iconVisible'] = true;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        dummyData[index]['iconVisible'] = false;
      });
    });
  }

  final List<VideoPlayerController> _controllers = [];
  final int _videoCount = 7;
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < dummyData.length; i++) {
      final controller = VideoPlayerController.network(dummyData[i]["reel"]);

      controller.addListener(() {
        if (controller.value.hasError) {
          print('Video ${i + 1} error: ${controller.value.errorDescription}');
        } else if (controller.value.isInitialized) {
          print('Video ${i + 1} is initialized.');
          if (i == _currentIndex) {
            // Ensure the first video plays automatically
            controller.play();
          }
        }
        if (controller.value.position == controller.value.duration) {
          controller.seekTo(Duration.zero);
          controller.play();
        }
      });

      controller.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
        print('Video ${i + 1} initialized.');
      }).catchError((error) {
        print('Error initializing video ${i + 1}: $error');
      });

      _controllers.add(controller);
    }

    _pageController.addListener(() {
      int newIndex = _pageController.page?.round() ?? 0;
      if (_currentIndex != newIndex) {
        setState(() {
          _currentIndex = newIndex;
          _updateVideoPlayback();
        });
      }
    });
  }

  void _updateVideoPlayback() {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == _currentIndex) {
        _controllers[i].seekTo(Duration.zero);
        _controllers[i].play();
      } else {
        _controllers[i].pause();
      }
    }
  }

  void _togglePlayPause(int index) {
    VideoPlayerController controller = _controllers[index];
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Reels",
          style: TextStyle(
            fontSize: screenWidth * 0.09,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo_camera_back_outlined, size: screenWidth * 0.1),
            color: Colors.white,
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videoCount,
        itemBuilder: (context, index) {
          if (index >= _controllers.length) {
            return Center(child: Text('Video not available'));
          }

          final data = dummyData[index];
          VideoPlayerController controller = _controllers[index];

          return Container(
            width: screenWidth,
            height: screenHeight,
            child: GestureDetector(
              onTap: () {
                if (_currentIndex == index) {
                  _togglePlayPause(index);
                }
              },
              child: InkWell(
                onDoubleTap: () {
                  setState(() {
                    if (!data['liked']) {
                      data['likes'] = (data['likes'] as int) + 1;
                      data['liked'] = true;
                      _showIconForDuration(index);
                    }
                  });
                },
                child: Stack(
                  children: [
                    controller.value.isInitialized
                        ? VideoPlayer(controller)
                        : Center(child: CircularProgressIndicator()),
                    if (data['iconVisible'] as bool)
                      Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.grey.shade200,
                          size: 100,
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent
                          ],
                          begin: Alignment(0, -0.75),
                          end: Alignment(0, 0.1),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent
                          ],
                          end: Alignment(0, -0.75),
                          begin: Alignment(0, 0.1),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              flex: 11,
                              child: Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      horizontalTitleGap: 12,
                                      title: Text("username - Follow",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            "https://picsum.photos/id/${index + 1047}/800/1080"),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 11),
                                      child: ExpandableText(
                                        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                                        style: TextStyle(fontSize: 15, color: Colors.white),
                                        expandText: '...',
                                        collapseText: 'less',
                                        expandOnTextTap: true,
                                        collapseOnTextTap: true,
                                        maxLines: 1,
                                        linkColor: Colors.grey,
                                      ),
                                    ),
                                    ListTile(
                                      dense: true,
                                      horizontalTitleGap: 10,
                                      title: Text("Music Title - Original Audio",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      leading: Icon(Icons.graphic_eq_outlined,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                height: 350,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!data['liked']) {
                                            data['likes'] = (data['likes'] as int) + 1;
                                            data['liked'] = true;
                                          } else {
                                            data['likes'] = (data['likes'] as int) - 1;
                                            data['liked'] = false;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        data['liked'] ? Icons.favorite : Icons.favorite_border,
                                        color: data['liked'] ? Colors.pink : Colors.white,
                                        size: 30,
                                      ),
                                      color: Colors.white,
                                    ),
                                    Text("${data['likes']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.mode_comment_outlined),
                                      iconSize: 40,
                                      color: Colors.white,
                                    ),
                                    Text("${data['comments']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.send),
                                      iconSize: 40,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_horiz),
                                      iconSize: 40,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/images/Wallpaer.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}