import 'package:flutter/material.dart';

class DetailPlantBackground extends StatelessWidget {
  final screenHeight, screenWidth;
  final String plantName;
  const DetailPlantBackground(
      {Key key, this.screenHeight, this.screenWidth, this.plantName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: -screenWidth * 0.27,
          top: -screenWidth * 0.4,
          child: Container(
            height: screenWidth * 1.2,
            width: screenWidth * 1.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Colors.green),
            ),
          ),
        ),
        Positioned(
          left: 30,
          right: 20,
          top: screenHeight * 0.10,
          child: Text(
            plantName,
            style: TextStyle(
              color: Color(0xFFECECEC).withOpacity(0.8),
              fontSize: 75,
              fontFamily: 'Noteworthy',
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
