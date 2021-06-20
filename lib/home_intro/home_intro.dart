import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'widgets/intro_page.dart';

class HomeIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          IntroPage(
            backgroundColor: Colors.black,
            image: Image.asset("assets/images/depression.jpg"),
            diseaseName: "Depression",
            diseaseDescription:
                "   Depression causes feelings of sadness and/or a loss of interest in activities you once enjoyed.",
          ),
          IntroPage(
            backgroundColor: Color(0xffD9D8D6),
            image: Image.asset("assets/images/bipolar.jpg"),
            diseaseName: "Bipolar",
            diseaseDescription:
                "   Bipolar is a condition that affects your moods, which can swing from one extreme to another.",
          ),
        ],
        enableLoop: true,
        fullTransitionValue: 200,
        enableSlideIcon: true,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.48,
      ),
    );
  }
}
