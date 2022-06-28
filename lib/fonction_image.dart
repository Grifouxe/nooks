import 'package:flutter/material.dart';

class img extends StatelessWidget{
  String image;
  double height;
  double width;

  img({
    required this.image,
    required this.height,
    required this.width,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      )
    );
  }
}