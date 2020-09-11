import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/models/user_model.dart';
import 'package:story/pages/faq_page.dart';
import 'package:story/pages/userProfile/deviceList.dart';
import 'package:story/pages/userProfile/passwordChange.dart';
import 'package:story/pages/userProfile/plantList.dart';
import 'package:story/services/database_service.dart';
import 'package:story/shared/loading2.dart';
import 'package:story/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  int _takenUserID = 0;

  Future _getUserStatistics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      var takenUserID = prefs.getInt('user_id');
      _takenUserID = takenUserID;
    } else {
      print("local storage null veri yok !");
    }

    var data = await http.get(
        "http://sedefbostanci.pythonanywhere.com/get_statics/" +
            "$_takenUserID");

    var jsonData = json.decode(data.body);
    print(jsonData);
    print("burda --------------------------");

    List keysList = [];
    List valuesList = [];
    jsonData.keys.forEach((key) {
      print(key);
      keysList.add(key);
    });
    jsonData.values.forEach((key) {
      print(key);
      valuesList.add(key);
    });

    print(keysList);
    print(valuesList);
    return keysList + valuesList;
  }

  Widget _userStatistics() {
    //List _keysList;
    return FutureBuilder(
      future: _getUserStatistics(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Text(
              "Loading..",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.hasError || snapshot.data.length == 0) {
          return Center(
            child: Text("You dont have plants yet."),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (int i = 0; i < snapshot.data.length / 2; i++)
                _items(
                    snapshot.data[i + (snapshot.data.length / 2).toInt()]
                        .toString(),
                    snapshot.data[i]),
            ],
          );
        }
      },
    );
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
          child: Text(
            'User Profile',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              textStyle: TextStyle(color: Colors.black),
            ),
          ),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //color: Colors.green,
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
                                Hero(
                                  tag: "avatar",
                                  child: CircleAvatar(
                                    maxRadius: 50.0,
                                    backgroundImage: NetworkImage(
                                        "https://scribbleghost.net/wp-content/uploads/2019/07/ScribbleGhost-Logo-White-PNG-558px.png"),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  _profileUser.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  _profileUser.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
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
                            child: _userStatistics(),
                            /*child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //_getUserStatistics(),
                                //_items("3", "TOTAL DEVICES"),
                                //_items("12", "TOTAL PLANTS"),
                                /* _items("--------", "------ "),
                                _items("--------", "------ "),*/
                              ],
                            ),*/
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
