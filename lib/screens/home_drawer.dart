import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/homescreen.dart';
import 'package:story/models/user_data.dart';
import 'package:story/pages/user_profile.dart';
import 'package:story/services/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.lightGreenAccent[700],
            //Theme.of(context).accentColor,
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
                          'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    currentUserId,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'UserSample@email',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Log Out',
              style: TextStyle(fontSize: 18.0),
            ),
            //onTap: null,
            onTap: () {
              //Navigator.of(context).pushNamed(UserProfile.routeName);
              Navigator.of(context).pop(UserProfile);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: AuthService.logout,
          ),
        ],
      ),
    );
  }
}
