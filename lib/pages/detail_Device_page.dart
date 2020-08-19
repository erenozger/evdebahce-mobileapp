import 'package:flutter/material.dart';
import 'package:story/pages/menu_page.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:story/shared/loading.dart';

class DetailDevicePage extends StatefulWidget {
  final Device recordDevice;
  final int currentPosition;

  const DetailDevicePage(
      {Key key, @required this.recordDevice, this.currentPosition})
      : super(key: key);

  @override
  _DetailDevicePageState createState() =>
      _DetailDevicePageState(recordDevice, currentPosition);
}

class _DetailDevicePageState extends State<DetailDevicePage> {
  //Future<List<DevicePlant>> _getDevicePlants() async {
  Future<List<DevicePlant>> _getDevicePlants() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cguiCSVXLS?indent=2");
    var jsonData = json.decode(data.body);

    List<DevicePlant> allDevicePlants = [];
    for (var p in jsonData) {
      try {
        DevicePlant deviceplants = DevicePlant(
            p["index"],
            p["devicePlants_ID"],
            p["uDevice_ID"],
            p["spot_1_ID"],
            p["spot_2_ID"],
            p["spot_3_ID"],
            p["spot_4_ID"],
            p["spot_5_ID"],
            p["spot_6_ID"],
            p["currentSpotSize"]);
        allDevicePlants.add(deviceplants);
      } catch (e) {
        print("hata burda !!!");
        print(e);
        print(allDevicePlants);
      }
    }

    return allDevicePlants;
  }

  List images = [
    "https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg",
    "https://smartgardenguide.com/wp-content/uploads/2019/09/click-and-grow-smart-garden-9-photo-3-1024x680.jpeg",
    "https://athomeinthefuture.com/wp-content/uploads/2016/08/clickandgrow-720x447@2x.jpg"
  ];
  Device recordDevice;
  int currentPosition;
  _DetailDevicePageState(this.recordDevice, this.currentPosition);
  List<Color> colorList = [
    Colors.blue,
    Colors.grey[200],
  ];
  bool toggle = false;
  Map<String, double> waterMap = Map();
  @override
  void initState() {
    super.initState();
    waterMap.putIfAbsent(
        "Water Level", () => recordDevice.device_WaterLevel * 100);
    waterMap.putIfAbsent(
        "Empty Area", () => (100 - (recordDevice.device_WaterLevel * 100)));
  }

  Widget _plantsWidget() {
    return Container(
      child: FutureBuilder(
          future: _getDevicePlants(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print("data null");
              return Column(
                children: <Widget>[
                  Loading(),
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Your plants on This Device",
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _onePlantCard(snapshot.data[0].spot_1_ID),
                        _onePlantCard(snapshot.data[0].spot_2_ID),
                        _onePlantCard(snapshot.data[0].spot_3_ID),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _onePlantCard(snapshot.data[0].spot_4_ID),
                        _onePlantCard(snapshot.data[0].spot_5_ID),
                        _onePlantCard(snapshot.data[0].spot_6_ID),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget _onePlantCard(int plantID) {
    if (plantID == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          width: 100,
          child: Card(
            shadowColor: Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.grey[200],
            elevation: 5.0,
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      );
    } else {}
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text(
                          recordDevice.device_Name,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 40,
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Added Date : " + recordDevice.connection_Date,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        SizedBox(height: 10.0),
                        Text(
                          'Detailed Description of this device!!',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 15,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 20.0),
                        Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 10),
                    child: Text(
                      "Your Device's Water Level",
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 15,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  PieChart(
                    dataMap: waterMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.left,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.ring,
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.black38),
                  _plantsWidget(),
                  Divider(color: Colors.black38),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        color: Colors.green,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 250,
                    child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  images[index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  )
                ],
              ),
            ),
            /*Positioned(
              right: -10,
              child: Image.asset(
                "assets/images/loginPhoto.png",
                height: 250,
              ),
            ),*/
            /*Positioned(
              right: 10,
              child: Text(
                '$currentPosition',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 55,
                    color: Colors.grey[900].withOpacity(0.10),
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.left,
              ),
            ),*/
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
}

class DevicePlant {
  final int index;
  final int devicePlants_ID;
  final int uDevice_ID;
  final String spot_1_ID;
  final String spot_2_ID;
  final String spot_3_ID;
  final String spot_4_ID;
  final String spot_5_ID;
  final String spot_6_ID;
  final int currentSpotSize;

  DevicePlant(
      this.index,
      this.devicePlants_ID,
      this.uDevice_ID,
      this.spot_1_ID,
      this.spot_2_ID,
      this.spot_3_ID,
      this.spot_4_ID,
      this.spot_5_ID,
      this.spot_6_ID,
      this.currentSpotSize);
}