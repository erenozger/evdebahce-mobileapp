import 'package:flutter/material.dart';
import 'package:story/models/user_model.dart';
import 'package:story/pages/faq_page.dart';
import 'package:story/pages/userProfile/deviceList.dart';
import 'package:story/pages/userProfile/passwordChange.dart';
import 'package:story/pages/userProfile/plantList.dart';
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
  int _selectedButton = 0;
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
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    /*decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),*/
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.black38,
                        ),
                        Align(
                          alignment: Alignment(0, -0.7),
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: 50.0,
                                  backgroundImage: NetworkImage(
                                      "https://scribbleghost.net/wp-content/uploads/2019/07/ScribbleGhost-Logo-White-PNG-558px.png"),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  _profileUser.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  _profileUser.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black45,
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _items("3", "TOTAL DEVICES"),
                                _items("12", "TOTAL PLANTS"),
                                _items("--------", "------ "),
                                _items("--------", "------ "),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.devices,
                                  color: _selectedButton == 0
                                      ? Colors.green
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedButton = 0;
                                  });
                                },
                              ),
                              Text(
                                "Devices",
                                style: TextStyle(
                                    color: _selectedButton == 0
                                        ? Colors.green
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.insert_chart,
                                color: _selectedButton == 1
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedButton = 1;
                                });
                              },
                            ),
                            Text(
                              "Plants",
                              style: TextStyle(
                                  color: _selectedButton == 1
                                      ? Colors.green
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: _selectedButton == 2
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedButton = 2;
                                });
                              },
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                  color: _selectedButton == 2
                                      ? Colors.green
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: _loadPage(_selectedButton, _profileUser.email),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _items(subtitle, title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _loadPage(int selectedNum, String email) {
    if (selectedNum == 0) {
      return UserDeviceList();
    } else if (selectedNum == 1) {
      return UserPlantList();
    } else if (selectedNum == 2) {
      return PasswordChangePage(
        currentUserMail: email,
      );
    }
  }
}
