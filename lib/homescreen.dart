import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/models/user_data.dart';
import 'package:story/screens/home_drawer.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:story/models/menu_options.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/pages/page2.dart';
import 'package:story/pages/page3.dart';
import 'package:story/pages/page4.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  final List<Widget> screens = [
    PageNumber2(),
    MenuPage(),
    PageNumber3(),
    PageNumber4(),
  ];
  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.green,
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
      drawer: HomeDrawer(
        currentUserId: currentUserId,
        userId: currentUserId,
      ),
      body: screens[_currentNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            title: Text('My Devices'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            title: Text('Bluetooth'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(
              'Notifications',
              //style: TextStyle(color: Colors.lightGreenAccent[700]),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
