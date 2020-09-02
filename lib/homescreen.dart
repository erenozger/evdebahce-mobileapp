import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:story/models/user_data.dart';
import 'package:story/pages/faq_page.dart';
import 'package:story/screens/home_drawer.dart';
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
      //backgroundColor: Color(0xFFFAFAFA),
      backgroundColor: Color(0xFF202020),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        brightness: Brightness.light,
        backgroundColor: Color(0xFF202020), //Colors.grey[200],
        title: Center(
          child: Text('Evde Bahce',
              //textAlign: TextAlign.center,
              /*style: TextStyle(
              fontFamily: 'Billabong',
              color: Colors.grey[800],
              fontSize: 30.0,
              //fontWeight: FontWeight,
            ),*/
              style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  textStyle: TextStyle(color: Colors.white))),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.grey[800],
            child: Icon(
              Icons.question_answer,
              color: Colors.white,
            ),
            /*Text(
              'FAQs',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),*/
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
          iconSize: 27,
          selectedItemColor: Colors.green, //Colors.grey[900],
          unselectedLabelStyle: TextStyle(color: Color(0xFF1B1B1B)),
          unselectedItemColor: Color(0xFF888888),
          //type: BottomNavigationBarType.fixed,
          //backgroundColor: Colors.grey[200],
          backgroundColor: Color(0xFF1B1B1B),
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color(0xFF1B1B1B),
                icon: Icon(Icons.home),
                title: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                )
                /*Text(
                'Dashboard',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                ),
            BottomNavigationBarItem(
                backgroundColor: Color(0xFF1B1B1B),
                icon: Icon(Icons.devices),
                title: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                )
                /*Text(
                'My Devices',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                ),
            BottomNavigationBarItem(
                backgroundColor: Color(0xFF1B1B1B),
                icon: Icon(Icons.bluetooth),
                title: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                ) /*Text(
                'Bluetooth',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                ) /*Text(
                'Notifications',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                ),
              ),*/
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
