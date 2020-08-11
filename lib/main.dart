import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story/data.dart';
import 'package:story/homescreen.dart';
import 'package:story/models/story_model.dart';
import 'package:story/models/user_data.dart';
import 'package:story/models/user_model.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:story/screens/story_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return HomeScreen();
        } else {
          /*return StoryScreen(
            stories: stories,
          );*/
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Evde bahce Description Stories',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: StoryScreen(stories: stories),
        home: _getScreenId(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
        },
      ),
    );
  }
}
