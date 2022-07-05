import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class_a/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwicher extends StatelessWidget {
  const ThemeSwicher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var switchIcon = Icon(
      themeProvider.isDarkMode
          ? CupertinoIcons.moon_fill
          : CupertinoIcons.sun_max_fill,
    );

    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      icon: switchIcon,
    );
  }
}
