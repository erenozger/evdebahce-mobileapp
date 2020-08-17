import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:story/models/menu_options.dart';
import 'package:story/pages/detail_Device_page.dart';
import 'package:story/pages/single_device.dart';
import 'package:story/shared/loading.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedOption = 0;
  List<Device> allDevices = [];
  Future<List<Device>> _getDevices() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cfbHHzozhe?indent=2");
    var jsonData = json.decode(data.body);
    //print("jsondata burda : " + "$jsonData");
    List<Device> allDevices = [];
    for (var dev in jsonData) {
      try {
        Device device = Device(
            dev["index"],
            dev["uDevice_ID"],
            dev["user_ID"],
            dev["device_ID"],
            dev["device_Name"],
            dev["connection_Date"],
            dev["wifi_Name"],
            dev["wifi_Password"],
            dev["device_WaterLevel"]);
        allDevices.add(device);
      } catch (e) {
        print(e);
      }
    }

    return allDevices;
  }

  Widget _devicesWidget() {
    return Container(
      child: FutureBuilder(
          future: _getDevices(),
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
              /*Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );*/
            } else {
              return SafeArea(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
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
                      height: 20,
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
                                          recordDevice: snapshot.data[index], currentPosition : index+1),
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
                                                fontSize: 24,
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
                                                fontSize: 23,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 20),
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

              /*return Container(
                child: Center(
                  child: Text("All devices reached..."),
                ),
              );*/
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
        /*Expanded(
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
        ),*/
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
  final double device_WaterLevel;

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
