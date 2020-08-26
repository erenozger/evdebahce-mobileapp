import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/models/menu_options.dart';
import 'package:story/pages/addDevice_page.dart';
import 'package:story/pages/detail_Device_page.dart';
import 'package:story/pages/single_device.dart';
import 'package:story/shared/loading.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    _getNewDevices();
  }

  int _selectedOption = 0;
  int _takenUserID = 0;

  List<DeviceNew> allNewDevices = [];
  Future<List<DeviceNew>> _getNewDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      var takenUserID = prefs.getInt('user_id');
      _takenUserID = takenUserID;
      print("TAKEN USER ID ->" + "$_takenUserID");
    } else {
      print("local storage null veri yok !");
    }

    var data = await http.get(
        //"http://192.168.88.17:8000/userDevices/get_userDevice/?user_ID=$_takenUserID");
        "http://sedefbostanci.pythonanywhere.com/userDevices/get_userDevice/?user_ID=$_takenUserID");
    //"https://next.json-generator.com/api/json/get/EygJ-2PMt");
    var jsonData = json.decode(data.body);

    List<DeviceNew> allNewDevices = [];
    for (var i in jsonData) {
      try {
        DeviceNew deviceNew = DeviceNew(
            i["id"],
            i["user_id"],
            i["device_id"],
            i["connection_Date"],
            i["wifi_name"],
            i["wifi_password"],
            i["device_WaterLevel"],
            i["device_Name"]);
        allNewDevices.add(deviceNew);
      } catch (e) {
        print("matching hatası");
        print(e);
      }
    }
    print(allNewDevices);
    return allNewDevices;
  }

  Widget _devicesWidget() {
    return Container(
      child: FutureBuilder(
          //future: _getDevices(), //hazır json kullanarak
          future: _getNewDevices(), //django backend API
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print("data null");
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Loading(),
                ],
              );
            } else {
              return SafeArea(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      'Your Devices',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 35,
                        color: (Colors.green),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      height: 400,
                      child: Swiper(
                        itemCount: snapshot.data.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.green,
                            color: Colors.grey[900],
                            activeSize: 20,
                            space: 8,
                          ),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      DetailDevicePage(
                                          recordDevice: snapshot.data[index],
                                          currentPosition: index + 1),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular((32)),
                                      ),
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 120),
                                            Text(
                                              snapshot.data[index].device_Name,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              snapshot
                                                  .data[index].connection_Date,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "See Details..",
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    "assets/images/loginPhoto.png",
                                    height: 150,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

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
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, a, b) => AddDevicePage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
              backgroundColor: Colors.green,
            ),
            title: Text('ADD Device'),
            subtitle: Text('Please click to add button to Add new Device'),
          ),
        ),
        _devicesWidget(),
      ],
    );
  }
}

class Device {
  final int index;
  final int uDevice_ID;
  final int user_ID;
  final int device_ID;
  final String device_Name;
  final String connection_Date;
  final String wifi_Name;
  final String wifi_Password;
  final String device_WaterLevel;

  Device(
      this.index,
      this.uDevice_ID,
      this.user_ID,
      this.device_ID,
      this.device_Name,
      this.connection_Date,
      this.wifi_Name,
      this.wifi_Password,
      this.device_WaterLevel);
}

class DeviceNew {
  final int id;
  final int user_id;
  final int device_id;
  final String connection_Date;
  final String wifi_name;
  final String wifi_password;
  final String device_WaterLevel;
  final String device_Name;

  DeviceNew(
      this.id,
      this.user_id,
      this.device_id,
      this.connection_Date,
      this.wifi_name,
      this.wifi_password,
      this.device_WaterLevel,
      this.device_Name);
}
