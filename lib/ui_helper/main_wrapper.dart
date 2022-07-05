import 'package:flutter/material.dart';
import 'package:flutter_class_a/screens/home_page.dart';
import 'package:flutter_class_a/screens/marker_view_screen.dart';
import 'package:flutter_class_a/screens/profile_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
