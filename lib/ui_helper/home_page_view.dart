import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  PageController controller;
  HomePageView({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  var images = [
    'a1.png',
    'a2.png',
    'a3.png',
    'a4.png',
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }

  Widget myPages(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        'images/$image',
        fit: BoxFit.fill,
      ),
    );
  }
}
