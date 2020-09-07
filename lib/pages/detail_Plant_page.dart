import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:story/pages/backgrounds/DetailPlant_background.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/services/database_service.dart';
import 'package:story/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sweetalert/sweetalert.dart';

class DetailPlant extends StatefulWidget {
  final DeviceNew recordDevice;
  final int spotID;
  final int currentSpot;

  const DetailPlant(
      {Key key,
      @required this.recordDevice,
      @required this.spotID,
      this.currentSpot})
      : super(key: key);
  @override
  _DetailPlantState createState() =>
      _DetailPlantState(recordDevice, spotID, currentSpot);
}

class _DetailPlantState extends State<DetailPlant> {
  DeviceNew _recordDevice;
  int _takenSpotID;
  int _currentSpot;
  _DetailPlantState(this._recordDevice, this._takenSpotID, this._currentSpot);

  Future<List<DeviceSpots>> _getDeviceSpots() async {
    print("taken spot ID PRINT ---------------------------");
    print(_takenSpotID);
    print("taken spot ID PRINT ---------------------------");

    var data = await http.get(
        //"http://192.168.88.17:8000/deviceSlots/deviceSlots_get/?spot_ID=" +
        "http://sedefbostanci.pythonanywhere.com/deviceSlots/deviceSlots_get/?spot_ID=" +
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
                    plantName: snapshot.data[0].plant_Name,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 32),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.search, color: Colors.white),
                            ],
                          ),
                        ),
                        _plantContentWidget(
                            screenHeight, screenWidth, snapshot.data[0]),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _plantContentWidget(screenHeight, screenWidth, takenPlantInfo) {
    int _remainingTime = takenPlantInfo.remaining_Time;
    int _avgGrowTime = takenPlantInfo.avg_GrowTime;
    String _startingDate = takenPlantInfo.starting_Date;
    DateTime dob = DateTime.parse(_startingDate);
    Duration dur = DateTime.now().difference(dob);
    String _differenceInHours = (dur.inHours).floor().toString();
    String _differenceInMinutes = (dur.inMinutes).floor().toString();
    int _mindiff = int.parse(_differenceInMinutes);
    _mindiff = _mindiff - 60 * 12;
    int _hourDiff;
    int _printHours;
    if (int.parse(_differenceInHours) > 24) {
      _hourDiff = 23 - ((int.parse(_differenceInHours) - 12) % 24);
      _printHours = (_hourDiff);
    } else {
      _hourDiff = (int.parse(_differenceInHours) - 12);
      _printHours = (23 - _hourDiff);
    }

    int _remainingMinutes = ((_remainingTime * 1440 - _mindiff) % 60);
    double _remainingDays = ((_remainingTime * 1440 - _mindiff) / 1440);
    int _printDays = _remainingDays.toInt();
    double _progressValue = _mindiff / (_avgGrowTime * 1440);
    print("progress value : " + "$_progressValue");
    String _formattedProgressValue = _progressValue.toStringAsFixed(2);

    double _tempPv = double.parse(_formattedProgressValue);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: screenHeight * 0.15),
          Hero(
            tag: takenPlantInfo.id,
            child: Image.asset(
                "assets/images/" + takenPlantInfo.plant_Name + ".png",
                height: screenHeight * 0.3),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.timer,
                size: 75,
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width / 2,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: _progressValue,
                          center: Text(_formattedProgressValue + "%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.green,
                        ),
                      ),
                      Text("$_printDays" +
                          "days " +
                          "$_printHours" +
                          "hours " +
                          "$_remainingMinutes" +
                          "minutes left."),
                    ],
                  ),
                  /*Container(
                    width: screenWidth * 0.5,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    child: AnimatedContainer(
                      height: 10,
                      width: screenWidth * 0.25,
                      duration: Duration(
                          hours: (takenPlantInfo.avg_GrowTime -
                              takenPlantInfo.remaining_Time)),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Starting Date*",
                style: TextStyle(
                    color: Color(0xFF909090),
                    fontSize: 10,
                    fontWeight: FontWeight.w900),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: takenPlantInfo.starting_Date,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(
                takenPlantInfo.plant_Name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            takenPlantInfo.plant_Description,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF909090),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                "Plant Tips",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            takenPlantInfo.plant_Tips,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF909090),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Color(0xFFECECEC),
            thickness: 2,
            height: 32,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => print("delete plant işlemi geldi!"),
                        icon: Icon(
                          Icons.graphic_eq,
                          color: Color(0xFFDA1D21),
                          size: 35,
                        ),
                      ),
                      Text(
                        "Graph",
                        style: TextStyle(
                            color: Color(0xFFDA1D21), fontSize: 10, height: 1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => print("delete plant işlemi geldi!"),
                        icon: Icon(
                          Icons.timeline,
                          color: Color(0xFFDA1D21),
                          size: 35,
                        ),
                      ),
                      Text(
                        "Timeline",
                        style: TextStyle(
                            color: Color(0xFFDA1D21), fontSize: 10, height: 1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () =>
                            _deletePlant(takenPlantInfo.id, _currentSpot),
                        icon: Icon(
                          Icons.delete,
                          color: Color(0xFFDA1D21),
                          size: 35,
                        ),
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                            color: Color(0xFFDA1D21), fontSize: 10, height: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFECECEC),
            thickness: 2,
            height: 32,
          ),
        ],
      ),
    );
  }

  Future<void> _deletePlant(int spotID, int spotNumber) async {
    SweetAlert.show(context,
        subtitle: "Do you want to delete this plant",
        style: SweetAlertStyle.confirm,
        showCancelButton: true, onPress: (bool isConfirm) {
      if (isConfirm) {
        _deletePlant2(spotID, spotNumber);
        SweetAlert.show(context,
            subtitle: "Deleting...", style: SweetAlertStyle.loading);
        new Future.delayed(new Duration(seconds: 2), () {
          SweetAlert.show(context,
              subtitle: "Success!", style: SweetAlertStyle.success);
          Navigator.popUntil(context, ModalRoute.withName('/'));
        });
      } else {
        SweetAlert.show(context,
            subtitle: "Canceled!", style: SweetAlertStyle.error);
      }
      // return false to keep dialog
      return false;
    });
  }

  Future<void> _deletePlant2(int spotID, int spotNumber) async {
    if (await DatabaseService.deletePlant(spotID, spotNumber) != null) {
      print("basarıyla silindi.");
    } else {
      print("silinemedi.");
    }
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
