import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:story/shared/loading2.dart';

class UserDeviceList extends StatefulWidget {
  @override
  _UserDeviceListState createState() => _UserDeviceListState();
}

class _UserDeviceListState extends State<UserDeviceList> {
  int _takenUserID = 0;
  bool _loading = false;
  List<DeviceNew> allNewDevices = [];
  Future<List<DeviceNew>> _getNewDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      var takenUserID = prefs.getInt('user_id');
      _takenUserID = takenUserID;
    } else {}

    var data = await http.get(
        "http://sedefbostanci.pythonanywhere.com/userDevices/get_userDevice/?user_ID=$_takenUserID");
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
        print(e);
      }
    }

    return allNewDevices;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Container(
            child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text("Your Devices",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              _devicesList(),
            ],
          ));
  }

  Widget _devicesList() {
    return Container(
      child: FutureBuilder(
        future: _getNewDevices(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Loading2(),
              ],
            );
          } else if (snapshot.hasError || snapshot.data.length == 0) {
            return Center(
              child: Text("You dont have device yet."),
            );
          } else {
            return SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                    "assets/images/waterlevel.png")),
                          ),
                          title: Text(snapshot.data[index].device_Name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[index].connection_Date),
                              new LinearPercentIndicator(
                                leading: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width / 2.3,
                                animation: true,
                                lineHeight: 18.0,
                                animationDuration: 2500,
                                percent: double.parse(
                                    snapshot.data[index].device_WaterLevel),
                                center: Text((double.parse(snapshot.data[index]
                                                .device_WaterLevel) *
                                            100)
                                        .toString() +
                                    "%"),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.blue[200],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
