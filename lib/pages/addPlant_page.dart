import 'package:flutter/material.dart';
import 'package:story/models/plants_model.dart';
import 'package:story/pages/menu_page.dart';

class AddPlantPage extends StatefulWidget {
  final DeviceNew recordDevice;
  final int currentSpot;
  const AddPlantPage(
      {Key key, @required this.recordDevice, @required this.currentSpot})
      : super(key: key);

  @override
  _AddPlantPageState createState() =>
      _AddPlantPageState(recordDevice, currentSpot);
}

class _AddPlantPageState extends State<AddPlantPage> {
  int _selectedPlant = 0;
  DeviceNew _recordDevice;
  int _currentSpot;
  _AddPlantPageState(this._recordDevice, this._currentSpot);

  Widget _plantsWidget(BuildContext context) {
    return SizedBox(
      height: 500,
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
              color: Colors.white,
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
                            ? Colors.green
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
    return Scaffold(
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
                  Text("Please select the plant you want to add to the device"),
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
    );
  }
}
