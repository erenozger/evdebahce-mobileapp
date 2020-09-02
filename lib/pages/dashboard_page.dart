import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
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
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Colors.white),
                                  child: Center(
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.green, size: 14.0),
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
                      _buildListItem('assets/images/Domates.png', 'Domates',
                          '\$200 - \$400'),
                      _buildListItem(
                          'assets/images/Biber.png', 'Biber', '\$50 - \$150'),
                      _buildListItem(
                          'assets/images/Marul.png', 'Marul', '\$300 - \$350'),
                      _buildListItem('assets/images/Semizotu.png', 'Semizotu',
                          '\$300 - \$350'),
                      _buildListItem('assets/images/Maydanoz.png', 'Maydanoz',
                          '\$300 - \$350'),
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
                /*Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Latest",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildListItem(String imgPath, String placeName, String price) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(children: [
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
                  )))),
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
              ))
        ]));
  }
}
