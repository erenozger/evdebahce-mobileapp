import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:story/shared/loading.dart';
import 'package:story/shared/loading2.dart';

class UserPlantList extends StatefulWidget {
  @override
  _UserPlantListState createState() => _UserPlantListState();
}

class _UserPlantListState extends State<UserPlantList> {
  int _takenUserID = 0;
  List<UserPlants> allUserPlants = [];
  Future<List<UserPlants>> _getUserPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      var takenUserID = prefs.getInt('user_id');
      _takenUserID = takenUserID;
    } else {}

    var data = await http
        .get("http://sedefbostanci.pythonanywhere.com/get_all/$_takenUserID");

    var jsonData = json.decode(data.body);

    List<UserPlants> allUserPlants = [];
    for (var i = 0; i < jsonData.length; i++) {
      try {
        UserPlants userPlants = UserPlants(
            jsonData[i][0],
            jsonData[i][1],
            jsonData[i][2],
            jsonData[i][3],
            jsonData[i][4],
            jsonData[i][5],
            jsonData[i][6],
            jsonData[i][7],
            jsonData[i][8],
            jsonData[i][9]);

        allUserPlants.add(userPlants);
      } catch (e) {
        print("hata burda !!!");
        print(e);
      }
    }

    return allUserPlants;
  }

  Widget _getUserPlantsWidget() {
    return Container(
      child: FutureBuilder(
        future: _getUserPlants(),
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
              child: Text("You dont have plants yet."),
            );
          } else {
            return SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 8, 8),
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
                                child: Image.asset("assets/images/" +
                                    snapshot.data[index].plant_Name +
                                    ".png")),
                          ),
                          title: Text("Device Name : " +
                              snapshot.data[index].device_Name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[index].plant_Name),
                              //Text(snapshot.data[index].starting_Date),
                              Text("Avg. Grow Time : " +
                                  snapshot.data[index].remaining_Time
                                      .toString() +
                                  " Days"),
                            ],
                          ),
                          trailing: GestureDetector(
                            child: Icon(
                              Icons.more_vert,
                            ),
                            onTap: () => _detailsPlant(snapshot.data[index]),
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

  _detailsPlant(UserPlants onePlant) {
    int _remainingTime = onePlant.remaining_Time;
    int _avgGrowTime = onePlant.avg_GrowTime;
    String _startingDate = onePlant.starting_Date;
    DateTime dob = DateTime.parse(_startingDate);
    Duration dur = DateTime.now().difference(dob);

    String _differenceInMinutes = (dur.inMinutes).floor().toString();
    int _mindiff = int.parse(_differenceInMinutes);
    _mindiff = _mindiff - 60 * 12;

    double _remainingDays = ((_remainingTime * 1440 - _mindiff) / 1440);
    int _printDays = _remainingDays.toInt();
    double _progressValue = _mindiff / (_avgGrowTime * 1440);
    print("progress value : " + "$_progressValue");
    String _formattedProgressValue = _progressValue.toStringAsFixed(2);
    double _tempPv = double.parse(_formattedProgressValue);
    int _printPercent = (_tempPv * 100).toInt();

    Alert(
            context: context,
            title: "DETAILS",
            content: Column(
              children: <Widget>[
                Text(
                  "Device Name : " + onePlant.device_Name,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    textStyle: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Plant grow date : " + "\n" + onePlant.starting_Date,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Only " + "$_printDays" + " Days to Harvest !",
                  style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
                new CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: _tempPv,
                  center: new Text(
                    "$_printPercent" + "%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: new Text(
                    "Reamining Chart",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
              )
            ],
            closeFunction: _backFunction)
        .show();
  }

  _backFunction() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text("Your Plants", style: TextStyle(fontWeight: FontWeight.w500)),
          _getUserPlantsWidget(),
        ],
      ),
    );
  }
}

class UserPlants {
  final String device_Name;
  final int id;
  final int remaining_Time;
  final String starting_Date;
  final String plant_Name;
  final int avg_GrowTime;
  final String plant_Description;
  final String device_Info;
  final int devicePlants_ID;
  final String plant_Tips;

  UserPlants(
      this.device_Name,
      this.id,
      this.remaining_Time,
      this.starting_Date,
      this.plant_Name,
      this.avg_GrowTime,
      this.plant_Description,
      this.device_Info,
      this.devicePlants_ID,
      this.plant_Tips);
}
