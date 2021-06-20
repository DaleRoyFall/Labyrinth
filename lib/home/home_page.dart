import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/home/profile/profile_page.dart';
import 'package:labyrinth/home/test/home_test_page.dart';

import 'post_wall/home_wall_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomePage();
  }
}

class _HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _currentIndex = 0;
  PageController _pageController;
  Color _backgroundColor;

  List<Color> colors = [
    Colors.indigo[50],
    Colors.purple[100],
    Colors.blue[100],
  ];

  @override
  void initState() {
    super.initState();
    _backgroundColor = colors[_currentIndex];
    _pageController = PageController();

    FirebaseCloudFirestore().getUserInfo(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white60,
          backgroundColor: _backgroundColor,
          index: _currentIndex,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.textsms_sharp, size: 30),
            Icon(Icons.person, size: 30),
          ],
          onTap: (index) => setState(() {
            _currentIndex = index;
            _backgroundColor = colors[index];
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _backgroundColor = colors[index];
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              HomeWallPage(
                backgroundColor: _backgroundColor,
              ),
              HomeTestPage(
                backgroundColor: _backgroundColor,
              ),
              ProfilePage(
                backgroundColor: _backgroundColor,
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
