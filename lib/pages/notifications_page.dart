import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NonificationsPage extends StatefulWidget {
  @override
  _NonificationsPageState createState() => _NonificationsPageState();
}

class _NonificationsPageState extends State<NonificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.notifications,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Your notifications shows on here",
            style: GoogleFonts.montserrat(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              "Your notifications based on the status of your device, the plants you added and the latest updates are displayed on this page.",
              style: GoogleFonts.montserrat(
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
                textStyle: TextStyle(color: Colors.white),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
