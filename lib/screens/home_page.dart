import 'package:flutter/material.dart';
import 'package:flutter_class_a/network/response_model.dart';
import 'package:flutter_class_a/provider/crypto_data_provider.dart';
import 'package:flutter_class_a/ui_helper/theme_swicher.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ui_helper/home_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 0);

  int defaultChoicesIndex = 0;

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losser'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cryptoPriver =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoPriver.getTopMarketCapData();
  }

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
              // * top banner
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
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
                    ],
                  ),
                ),
              ),
              // *marque text
              SizedBox(
                width: double.infinity,
                height: 30,
                child: Marquee(
                  text: '🔊 this is place for news in application ',
                  style: textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 5),
              //  * sell & buy btn
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade700,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Buy'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Sell'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // *choices chips
              Padding(
                padding: EdgeInsets.only(right: 5, left: 5),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(_choicesList.length, (index) {
                        return ChoiceChip(
                          label: Text(
                            _choicesList[index],
                            style: textTheme.titleSmall,
                          ),
                          selected: defaultChoicesIndex == index,
                          selectedColor: Colors.blue,
                          onSelected: (isSelected) {
                            setState(
                              () {
                                isSelected
                                    ? defaultChoicesIndex = index
                                    : defaultChoicesIndex;
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Consumer<CryptoDataProvider>(
                  builder: (context, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 80,
                          child: Shimmer.fromColors(
                            child: Row(children: []),
                            baseColor: Colors.grey.shade600,
                            highlightColor: Colors.white,
                          ),
                        );
                      case Status.COMPLETED:
                        return SizedBox(
                          height: 80,
                          child: Shimmer.fromColors(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    // *first item in shimmer
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8,
                                        bottom: 8,
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                    // *second item in shimmer
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 8, left: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 8,
                                              ),
                                              height: 15,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // *third item in shimmer
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Container(
                                        width: 70,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    // *fourth item in shimmer
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 8, left: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 8,
                                              ),
                                              height: 15,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                          ),
                        );
                      case Status.ERROR:
                        return Text(cryptoDataProvider.state.message);
                      default:
                        return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
