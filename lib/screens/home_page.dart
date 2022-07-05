import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_class_a/ui_helper/theme_swicher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ui_helper/home_page_view.dart';

class HomePage extends StatelessWidget {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Exchange flutter ui'),
        titleTextStyle: textTheme.titleLarge,
        actions: [
          ThemeSwicher(),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(children: [
                    HomePageView(
                      controller: pageController,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 4,
                        effect: ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                        ),
                        onDotClicked: (index) {
                          pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
