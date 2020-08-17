import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/models/user_data.dart';
import 'package:story/pages/faq_page.dart';

class DeviceDetails extends StatefulWidget {
  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    print("burda id basılacak " + '$currentUserId');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.grey[200],
        title: Center(
          child: Text('Single Device',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Noteworthy',
                color: Colors.grey[800],
                fontSize: 30.0,
                //fontWeight: FontWeight,
              )),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.grey[800],
            child: Text(
              'FAQs',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => (FAQPage()),
              ),
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/productPhoto1.jpg",
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
