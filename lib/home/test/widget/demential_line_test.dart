import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';

class DepentialLineTest extends StatefulWidget {
  DepentialLineTest({this.onChanged});

  final Function onChanged;

  @override
  _DepentialLineTestState createState() => _DepentialLineTestState();
}

class _DepentialLineTestState extends State<DepentialLineTest> {
  List<Offset> offsets = [];

  String result = "";

  Offset stackOffset;

  GlobalKey stackKey = GlobalKey();
  GlobalKey oneKey = GlobalKey();
  GlobalKey aKey = GlobalKey();
  GlobalKey twoKey = GlobalKey();
  GlobalKey bKey = GlobalKey();
  GlobalKey threeKey = GlobalKey();
  GlobalKey cKey = GlobalKey();
  GlobalKey fourKey = GlobalKey();
  GlobalKey dKey = GlobalKey();
  GlobalKey fiveKey = GlobalKey();
  GlobalKey eKey = GlobalKey();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = stackKey.currentContext.findRenderObject();
      stackOffset = box.localToGlobal(Offset.zero);

      box = oneKey.currentContext.findRenderObject();
      Offset offset = box.localToGlobal(Offset.zero);
      offsets.add(Offset(offset.dx + SizeConfig.adaptWidth(1),
          offset.dy - stackOffset.dy + SizeConfig.adaptHeight(1)));
      box = aKey.currentContext.findRenderObject();
      offset = box.localToGlobal(Offset.zero);
      offsets.add(Offset(offset.dx + SizeConfig.adaptWidth(1),
          offset.dy - stackOffset.dy + SizeConfig.adaptHeight(1)));

      result += "1A";

      setState(() {});
    });
  }

  _buildPointContainer(
    GlobalKey key,
    EdgeInsetsGeometry margin,
    String text,
  ) {
    return Container(
      width: SizeConfig.adaptWidth(9),
      height: SizeConfig.adaptWidth(9),
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ElevatedButton(
          child: Text(
            text,
            key: key,
            style: TextStyle(
                fontSize: SizeConfig.adaptFontSize(4),
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          onPressed: () {
            RenderBox box = key.currentContext.findRenderObject();
            Offset offset = box.localToGlobal(Offset.zero);
            Offset position = Offset(offset.dx + SizeConfig.adaptWidth(1),
                offset.dy - stackOffset.dy + SizeConfig.adaptHeight(1));
            setState(() {
              if (offsets.contains(position)) {
                result = result.substring(0, result.length - 1);
                offsets.remove(position);
              } else {
                result += text;
                offsets.add(position);
              }
            });

            widget.onChanged(result);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: LinePainter(offsets),
      child: Stack(
        key: stackKey,
        children: [
          _buildPointContainer(
              oneKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(10),
                top: SizeConfig.adaptHeight(10),
              ),
              "1"),
          _buildPointContainer(
              aKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(32),
                top: SizeConfig.adaptHeight(14),
              ),
              "A"),
          _buildPointContainer(
              twoKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(62),
                top: SizeConfig.adaptHeight(24),
              ),
              "2"),
          _buildPointContainer(
              bKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(42),
                top: SizeConfig.adaptHeight(2),
              ),
              "B"),
          _buildPointContainer(
              threeKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(26),
                top: SizeConfig.adaptHeight(22),
              ),
              "3"),
          _buildPointContainer(
              cKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(82),
                top: SizeConfig.adaptHeight(18),
              ),
              "C"),
          _buildPointContainer(
              fourKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(72),
                top: SizeConfig.adaptHeight(12),
              ),
              "4"),
          _buildPointContainer(
              dKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(22),
                top: SizeConfig.adaptHeight(2),
              ),
              "D"),
          _buildPointContainer(
              fiveKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(44),
                top: SizeConfig.adaptHeight(12),
              ),
              "5"),
          _buildPointContainer(
              eKey,
              EdgeInsets.only(
                left: SizeConfig.adaptWidth(62),
                top: SizeConfig.adaptHeight(4),
              ),
              "E"),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  Paint _paint;
  List<Offset> _offsets;

  LinePainter(List<Offset> offsets) {
    _offsets = offsets;
    _paint = Paint()
      ..color = Colors.white54
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _offsets.length - 1; i++) {
      canvas.drawLine(_offsets[i], _offsets[i + 1], _paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return true;
  }
}
