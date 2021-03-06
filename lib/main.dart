import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_class_a/provider/crypto_data_provider.dart';
import 'package:flutter_class_a/provider/market_view_provider.dart';
import 'package:flutter_class_a/provider/theme_provider.dart';
import 'package:flutter_class_a/ui_helper/main_wrapper.dart';
import 'package:flutter_class_a/ui_helper/theme_swicher.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
        ChangeNotifierProvider(create: (context) => MarketViewProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          darkTheme: MyThemes.darkTheme,
          theme: MyThemes.lightTheme,
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: MainWrapper(),
          ),
        );
      },
    );
  }
}
