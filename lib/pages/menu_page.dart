import 'package:flutter/material.dart';
import 'package:story/models/menu_options.dart';
import 'package:story/pages/single_device.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: FloatingActionButton(
              onPressed: () {
                print('device ekleme talebi alındı');
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
              backgroundColor: Colors.lightGreenAccent[700],
            ),
            title: Text('ADD Device'),
            subtitle: Text('Please click to add button to Add new Device'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: options.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox(height: 15.0);
              } else if (index == options.length + 1) {
                return SizedBox(height: 100.0);
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: _selectedOption == index - 1
                      ? Border.all(color: Colors.black26)
                      : null,
                ),
                child: ListTile(
                  leading: options[index - 1].icon,
                  title: Text(
                    options[index - 1].title,
                    style: TextStyle(
                      color: _selectedOption == index - 1
                          ? Colors.black
                          : Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    options[index - 1].subtitle,
                    style: TextStyle(
                      color: _selectedOption == index - 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  selected: _selectedOption == index - 1,
                  onTap: () {
                    setState(() {
                      _selectedOption = index - 1;
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => new DeviceDetails()));
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
