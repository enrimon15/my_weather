import 'package:flutter/material.dart';

class MyClipperCurved extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path(); //define path
    /*path.lineTo(0, size.height-50);
    path.lineTo(size.width, size.height-200);
    path.lineTo(size.width, 0);*/
    path.lineTo(0, size.height-50);
    path.quadraticBezierTo(size.width/4, size.height-100, size.width/2, size.height-50);
    path.quadraticBezierTo(size.width-(size.width/4), size.height, size.width, size.height-50);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  //true if a new instance in getClip is created, to compare with the old instance and reload the chaages
  //in test should use true, false in production
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}