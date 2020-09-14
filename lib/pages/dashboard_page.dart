import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story/models/device_types.dart';
import 'package:story/models/plants_model.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 15.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Device Description',
                          style: GoogleFonts.montserrat(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.white),
                          )),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 0.0),
                      child: Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/productPhoto1.jpg'),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken))),
                      ),
                    ),
                    Positioned(
                        top: 125.0,
                        left: 10.0,
                        child: Container(
                            width: MediaQuery.of(context).size.width - 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Infinia EvdeBahce',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            textStyle: TextStyle(
                                                color: Colors.white))),
                                    Text(
                                      'Prototype Number 1',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.0,
                                          textStyle:
                                              TextStyle(color: Colors.white)),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    _bottomDeviceDescription(
                                        context, allDevices[0]);
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        color: Colors.white),
                                    child: Center(
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.green, size: 14.0),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                    width: MediaQuery.of(context).size.width - 15.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Weekly Highlights',
                            style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              textStyle: TextStyle(color: Colors.white),
                            ))
                      ],
                    )),
                SizedBox(height: 15.0),
                Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      for (int i = 0; i < allPlants.length; i++)
                        _buildListItem(
                            allPlants[i].plant_Picture,
                            allPlants[i].plant_Name,
                            allPlants[i].avg_GrowTime.toString() +
                                " - " +
                                (allPlants[i].avg_GrowTime + 2).toString() +
                                " days.",
                            allPlants[i]),
                    ],
                  ),
                ),
                Text("Today",
                    style: GoogleFonts.montserrat(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 100.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.green.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Most saled Plant",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Lettuce",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Most Used City",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Ankara",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildListItem(
      String imgPath, String placeName, String price, PlantsModel onePlant) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
      child: Stack(
        children: [
          Container(
              height: 175.0,
              width: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken)))),
          Positioned(
            top: 15.0,
            right: 15.0,
            child: InkWell(
              onTap: () => _bottomPlantDescription(context, onePlant),
              child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
                child: Center(
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.green,
                    size: 14.0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 125.0,
            left: 15.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(placeName,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        textStyle: TextStyle(color: Colors.white))),
                Text(price,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        textStyle: TextStyle(color: Colors.white)))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _bottomPlantDescription(context, PlantsModel onePlant) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            //color: Color(0xFF202020),
            image: DecorationImage(
              image: AssetImage(onePlant.plant_Picture),
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.contain,
            ),
          ),
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 80,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(onePlant.plant_Picture)),
                    ),
                  ),
                  Text(
                    onePlant.plant_Name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                onePlant.plant_Description,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Ortalama Yetişme Süresi(Gün) : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    onePlant.avg_GrowTime.toString(),
                    style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }

  void _bottomDeviceDescription(context, DeviceType deviceType) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            //color: Color(0xFF202020),
            image: DecorationImage(
              image: NetworkImage(deviceType.deviceImage2),
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.contain,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.90,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Text(
                  deviceType.deviceName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 25),
                Text(
                  deviceType.deviceDescription,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.only(left: 0),
                  height: 200,
                  child: ListView.builder(
                      itemCount: 3,
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
                                deviceType.deviceImage1,
                                fit: BoxFit.cover,
                              )),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
