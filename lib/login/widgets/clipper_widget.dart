import 'package:flutter/cupertino.dart';

class ClipperWidget extends CustomClipper<Path> {
  ClipperWidget({this.waveList});
  List<Offset> waveList;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
