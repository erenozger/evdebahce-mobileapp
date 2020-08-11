import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent[700],
        title: Center(
          child: Text('Evde Bahce',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 32.0,
              )),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text(
              'HELP',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => print("help"),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "images/productPhoto1.jpg",
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('description number 1'),
          ),
        ],
      ),
    );
  }
}
