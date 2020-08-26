import 'package:flutter/material.dart';
import 'package:story/models/plants_model.dart';
import 'package:story/pages/detail_Device_page.dart';
import 'package:story/pages/menu_page.dart';
import 'package:story/services/database_service.dart';
import 'package:story/shared/loading.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:intl/intl.dart';

class AddPlantPage extends StatefulWidget {
  final DeviceNew recordDevice;
  final int currentSpot;
  //final DevicePlant takenDevicePlant;
  final int takenDevicePlants_ID;
  const AddPlantPage({
    Key key,
    @required this.recordDevice,
    @required this.currentSpot,
    //@required this.takenDevicePlant
    @required this.takenDevicePlants_ID,
  }) : super(key: key);

  @override
  _AddPlantPageState createState() =>
      _AddPlantPageState(recordDevice, currentSpot, takenDevicePlants_ID);
}

class _AddPlantPageState extends State<AddPlantPage> {
  bool loadingOption = false;
  int _selectedPlant = 0;
  DeviceNew _recordDevice;
  int _currentSpot;
  int _takenDevicePlants_ID;
  DevicePlant _takenDevicePlant;
  _AddPlantPageState(
      this._recordDevice, this._currentSpot, this._takenDevicePlants_ID);

  int _devicePlantsID;
  int _remainingTime;
  String _starting_Date;
  String _plantName;
  int _avg_Growtime;
  String _plant_Description;
  String _plant_Tips;
  String _device_Info;
  Future<void> _submitPlant2(
      int devicePlantsID,
      int remainingTime,
      String startingDate,
      String plantName,
      int avgGrowTime,
      String plantDescription,
      String plantTips,
      String deviceInfo) async {
    if (await DatabaseService.addPlants(
            devicePlantsID,
            remainingTime,
            startingDate,
            plantName,
            avgGrowTime,
            plantDescription,
            plantTips,
            deviceInfo,
            _currentSpot) !=
        null) {
      print("Plant başarıyla sisteme eklendi!");
    } else {
      print("Plant ekleme fonksiyonu çalışmadı!");
    }
  }

  Future<void> _submitPlant() async {
    print("submit plant geldi");

    SweetAlert.show(context,
        subtitle: "Do you want to add this plant ?",
        style: SweetAlertStyle.confirm,
        confirmButtonColor: Colors.green,
        cancelButtonColor: Colors.grey,
        showCancelButton: true, onPress: (bool isConfirm) {
      if (isConfirm) {
        _devicePlantsID = _takenDevicePlants_ID;
        _remainingTime = allPlants[_selectedPlant].avg_GrowTime;
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        _starting_Date = formattedDate;
        _plantName = allPlants[_selectedPlant].plant_Name;
        _avg_Growtime = allPlants[_selectedPlant].avg_GrowTime;
        _plant_Description = allPlants[_selectedPlant].plant_Description;
        _plant_Tips = allPlants[_selectedPlant].plant_Tips;
        _device_Info = "null";
        _submitPlant2(
            _devicePlantsID,
            _remainingTime,
            _starting_Date,
            _plantName,
            _avg_Growtime,
            _plant_Description,
            _plant_Tips,
            _device_Info);
        SweetAlert.show(context,
            subtitle: "Adding...", style: SweetAlertStyle.loading);

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

  Widget _plantsWidget(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: allPlants.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(
              height: 16,
            );
          } else if (index == allPlants.length + 1) {
            return SizedBox(
              height: 100,
            );
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: _selectedPlant == index - 1 ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: _selectedPlant == index - 1
                  ? Border.all(color: Colors.black26)
                  : null,
            ),
            child: SingleChildScrollView(
              child: ListTile(
                  leading: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(allPlants[index - 1].plant_Picture)),
                  ),
                  title: Text(
                    allPlants[index - 1].plant_Name,
                    style: TextStyle(
                      color: _selectedPlant == index - 1
                          ? Colors.black
                          : Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    allPlants[index - 1].plant_Tips,
                    style: TextStyle(
                        color: _selectedPlant == index - 1
                            ? Colors.black
                            : Colors.grey),
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      Icon(
                        Icons.done,
                        size: 40,
                        color: _selectedPlant == index - 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                  selected: _selectedPlant == index - 1,
                  onTap: () {
                    setState(() {
                      _selectedPlant = index - 1;
                    });
                  }),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loadingOption
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 0,
              /*title: Center(
          child: Text(
            "FAQs",
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontFamily: 'Noteworthy',
                fontWeight: FontWeight.bold),
          ),
        ),*/
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 30),
                              Text(
                                "Add Plant for Your Device",
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Current Device",
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _recordDevice.device_Name,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Current Device's Spot",
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Spot -> " + _currentSpot.toString(),
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Divider(color: Colors.black38),
                            ],
                          ),
                        ),
                        Text(
                            "Please select the plant you want to add to the device"),
                        _plantsWidget(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              width: double.infinity,
              height: 80.0,
              color: Color(0xFFF3F3F3),
              child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: _submitPlant,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'SAVE & CONTINUE',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
