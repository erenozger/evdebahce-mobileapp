import 'package:flutter/material.dart';

class DetailPlantBackground extends StatelessWidget {
  final screenHeight, screenWidth;

  const DetailPlantBackground({Key key, this.screenHeight, this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenWidth * 1.2,
          width: screenWidth * 1.2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Colors.green),
          ),
        ),
      ],
    );
  }
}
