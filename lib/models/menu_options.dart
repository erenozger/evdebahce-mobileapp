//import 'dart:html';

import 'package:flutter/material.dart';

class MenuOption {
  Icon icon;
  String title;
  String subtitle;

  MenuOption({this.icon, this.title, this.subtitle});
}

final options = [
  MenuOption(
    icon: Icon(
      Icons.dashboard,
      size: 40.0,
    ),
    title: 'Device One',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.do_not_disturb, size: 40.0),
    title: 'Device Two',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Device Three',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.invert_colors, size: 40.0),
    title: 'Device Four',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.watch_later, size: 40.0),
    title: 'Device Five',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.fastfood, size: 40.0),
    title: 'Device Six',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.local_airport, size: 40.0),
    title: 'Device Seven',
    subtitle: 'More information about this Device',
  ),
  MenuOption(
    icon: Icon(Icons.settings, size: 40.0),
    title: 'Device Eight',
    subtitle: 'More information about this Device',
  ),
];
