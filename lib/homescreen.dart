import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/models/user_data.dart';
import 'package:story/pages/faq_page.dart';
import 'package:story/screens/home_drawer.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:story/models/menu_options.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/pages/dashboard_page.dart';
import 'package:story/pages/page3.dart';
import 'package:story/pages/notifications_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  final List<Widget> screens = [
    DashboardPage(),
    MenuPage(),
    PageNumber3(),
    NonificationsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    print(currentUserId);
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.grey[200],
        title: Center(
          child: Text('Evde Bahce',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Billabong',
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
      drawer: HomeDrawer(
        currentUserId: currentUserId,
        userId: currentUserId,
      ),
      body: screens[_currentNavIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          selectedItemColor: Colors.green, //Colors.grey[900],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[200],
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  fontFamily: 'Noteworthy',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              title: Text(
                'My Devices',
                style: TextStyle(
                  fontFamily: 'Noteworthy',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth),
              title: Text(
                'Bluetooth',
                style: TextStyle(
                  fontFamily: 'Noteworthy',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontFamily: 'Noteworthy',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
