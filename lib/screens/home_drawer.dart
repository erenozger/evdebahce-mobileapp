import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/homescreen.dart';
import 'package:story/models/user_data.dart';
import 'package:story/models/user_model.dart';
import 'package:story/pages/user_profile.dart';
import 'package:story/services/auth_service.dart';
import 'package:story/services/database_service.dart';
import 'package:story/shared/loading.dart';

class HomeDrawer extends StatefulWidget {
  final String currentUserId;
  final String userId;
  HomeDrawer({this.currentUserId, this.userId});

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  User _profileUser;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _setupProfileUser();
  }

  _setupProfileUser() async {
    User profileUser = await DatabaseService.getUserWithId(widget.userId);
    setState(() {
      _profileUser = profileUser;
      loading = false;
      print(_profileUser.email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Drawer(
            elevation: 1.5,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  color: Colors.green,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 30,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://scribbleghost.net/wp-content/uploads/2019/07/ScribbleGhost-Logo-White-PNG-558px.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          //currentUserId,
                          _profileUser.name,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _profileUser.email,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        title: Text('My Profile'),
                        leading: Icon(Icons.person),
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => new UserProfile(
                                currentUserId: widget.userId,
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text('Settings'),
                        leading: Icon(Icons.settings),
                        onTap: () {},
                      ),
                      ListTile(
                          title: Text('Notifications'),
                          leading: Icon(Icons.notifications),
                          onTap: () {})
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 0.1,
                ),
                LogOutButton(),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "V1.0.0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "INFINIA Mühendislik",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "E-posta : info@infinia.com.tr",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 0.0),
        height: 30.0,
        child: RaisedButton(
          color: Colors.amber,
          onPressed: () {
            AuthService.logout();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: FittedBox(
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
