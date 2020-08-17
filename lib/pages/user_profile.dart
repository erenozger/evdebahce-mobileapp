import 'package:flutter/material.dart';
import 'package:story/models/user_model.dart';
import 'package:story/pages/faq_page.dart';
import 'package:story/services/database_service.dart';
import 'package:story/utilities/constants.dart';

class UserProfile extends StatefulWidget {
  final String currentUserId;
  final String userId;

  UserProfile({this.currentUserId, this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User _profileUser;

  @override
  void initState() {
    super.initState();
    _setupProfileUser();
  }

  _setupProfileUser() async {
    User profileUser = await DatabaseService.getUserWithId(widget.userId);
    setState(() {
      _profileUser = profileUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.grey[200],
        title: Center(
          child: Text('User Profile',
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
      body: FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          User user = User.fromDoc(snapshot.data);
          return ListView(
            children: <Widget>[
              Divider(),
              Text("hello profile page"),
              Text(_profileUser.email),
            ],
          );
        },
      ),
    );
  }
}
