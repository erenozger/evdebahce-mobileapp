import 'package:flutter/material.dart';

class ProjectAppBar extends StatelessWidget {
  final String title;

  ProjectAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800], fontSize: 20),
      ),
    );
  }
}
