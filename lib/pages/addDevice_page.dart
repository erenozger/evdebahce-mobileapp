import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/models/django_user.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/services/database_service.dart';

class AddDevicePage extends StatefulWidget {
  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final _deviceFormKey = GlobalKey<FormState>();
  String _deviceName,
      _deviceType,
      _devicePicture,
      _deviceDescription,
      _connectionDate;
  List<String> _deviceTypes = ["Infinia Device Type 1"];
  int _userID;

  Future<void> _submitDevice() async {
    print("submitdevice geldi!!");
    if (_deviceFormKey.currentState.validate()) {
      _deviceFormKey.currentState.save();
      print(_deviceName);
      print(_deviceType);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("log outdayız");
      if (prefs != null) {
        var token = prefs.getString('user_token');
        var token2 = prefs.getInt('user_id');
        _userID = token2;
      } else {
        print("local storage null veri yok !");
      }
      if (await DatabaseService.addDevice(_deviceName, _deviceType, _userID) !=
          null) {
        print("Device başarıyla sisteme eklendi!");
      } else {
        print("Device ekleme fonksiyonu çalışmadı!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text(
                          "Add Device Page",
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Please open your bluetooth and choose your device. ",
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  DeviceForm(),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget DeviceForm() {
    return Container(
      child: Column(
        children: <Widget>[
          Form(
            key: _deviceFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.add_to_queue),
                        labelText: 'Device Name'),
                    validator: (input) => input.trim().isEmpty
                        ? 'Please enter valid devicename!!'
                        : null,
                    onSaved: (input) => _deviceName = input,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80.0, 10, 40, 10),
                  child: DropdownButton(
                    hint: Text("Select your device type"),
                    value: _deviceType,
                    icon: Icon(Icons.arrow_drop_down, size: 36),
                    isExpanded: true,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _deviceType = value;
                      });
                    },
                    items: _deviceTypes.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: _submitDevice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Avenir',
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
