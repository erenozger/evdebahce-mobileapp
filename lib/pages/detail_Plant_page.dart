import 'package:flutter/material.dart';
import 'package:story/pages/backgrounds/DetailPlant_background.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPlant extends StatefulWidget {
  final DeviceNew recordDevice;
  final int spotID;

  const DetailPlant(
      {Key key, @required this.recordDevice, @required this.spotID})
      : super(key: key);
  @override
  _DetailPlantState createState() => _DetailPlantState(recordDevice, spotID);
}

class _DetailPlantState extends State<DetailPlant> {
  DeviceNew _recordDevice;
  int _takenSpotID;
  _DetailPlantState(this._recordDevice, this._takenSpotID);

  Future<List<DeviceSpots>> _getDeviceSpots() async {
    print("taken spot ID PRINT ---------------------------");
    print(_takenSpotID);
    print("taken spot ID PRINT ---------------------------");

    var data = await http.get(
        "http://192.168.88.17:8000/deviceSlots/deviceSlots_get/?spot_ID=" +
            "$_takenSpotID");
    //.get("http://www.json-generator.com/api/json/get/bTvxNrXjnm?indent=2");
    var jsonData = json.decode(data.body);

    List<DeviceSpots> allDeviceSpots = [];
    for (var p in jsonData) {
      try {
        DeviceSpots devicespots = DeviceSpots(
            p["id"],
            p["devicePlants_ID"],
            p["remaining_Time"],
            p["starting_Date"],
            p["plant_Name"],
            p["avg_GrowTime"],
            p["plant_Description"],
            p["plant_Tips"],
            p["device_Info"]);

        allDeviceSpots.add(devicespots);
      } catch (e) {
        print("hata burda !!!");
        print(e);
      }
      return allDeviceSpots;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: FutureBuilder(
        future: _getDeviceSpots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print("data null");
            return Loading();
          } else {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  DetailPlantBackground(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class DeviceSpots {
  final int id;
  final int devicePlants_ID;
  final int remaining_Time;
  final String starting_Date;
  final String plant_Name;
  final int avg_GrowTime;
  final String plant_Description;
  final String plant_Tips;
  final String device_Info;

  DeviceSpots(
      this.id,
      this.devicePlants_ID,
      this.remaining_Time,
      this.starting_Date,
      this.plant_Name,
      this.avg_GrowTime,
      this.plant_Description,
      this.plant_Tips,
      this.device_Info);
}
