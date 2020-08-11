import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story/data.dart';
import 'package:story/homescreen.dart';
import 'package:story/models/story_model.dart';
import 'package:story/models/user_model.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final List<Story> stories;

  const StoryScreen({@required this.stories});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  VideoPlayerController _videoController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    final Story firstStory = widget.stories.first;
    print(widget.stories.first);
    _loadStory(story: firstStory, animateToPage: false);

    _videoController = VideoPlayerController.network(widget.stories[2].url)
      ..initialize().then((value) => setState(() {}));
    _videoController.play();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.green,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, i) {
                final Story story = widget.stories[i];
                switch (story.media) {
                  case MediaType.image:
                    return CachedNetworkImage(
                      imageUrl: story.url,
                      fit: BoxFit.cover,
                    );
                  case MediaType.video:
                    if (_videoController != null &&
                        _videoController.value.initialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      );
                    }
                }
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: DescriptionInfo(
                user: story.user,
                story: widget.stories[_currentIndex],
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animationController: _animationController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    //child: DescriptionInfo(user: story.user),
                    child: StartButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          _currentIndex = 0;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _animationController.stop();
      } else {
        _videoController.play();
        _animationController.forward();
      }
    }
  }

  void _loadStory({Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    switch (story.media) {
      case MediaType.image:
        _animationController.duration = story.duration;
        _animationController.forward();
        break;
      case MediaType.video:
        _videoController = null;
        _videoController?.dispose();
        _videoController = VideoPlayerController.network(story.url)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController.value.initialized) {
              _animationController.duration = _videoController.value.duration;
              _videoController.play();
              _animationController.forward();
            }
          });
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key key,
    @required this.animationController,
    @required this.position,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animationController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 15.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

class DescriptionInfo extends StatelessWidget {
  final User user;
  final Story story;
  const DescriptionInfo({
    Key key,
    @required this.user,
    @required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
            //alignment: Alignment.centerRight,
            ),

        const SizedBox(width: 0),
        //Expanded(
        Container(
          padding: new EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text(
                story.descriptionNumber1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                story.descriptionNumber2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                story.descriptionNumber3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 0.0),
      height: 30.0,
      child: RaisedButton(
        color: Colors.white,
        //.lightGreen[50],

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: FittedBox(
          child: Text(
            'Start EvdeBahce INFINIA',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
