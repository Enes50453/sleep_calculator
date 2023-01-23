import 'package:flutter/material.dart';
import 'package:flutter_sleep_calculator/screens/info_page.dart';
import 'package:flutter_sleep_calculator/screens/sleep_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/alarm": (BuildContext context) => ScreenAlarm(),
        "/info": (BuildContext context) => SceenInfo()
      },
      initialRoute: "/alarm", //açılış sayfası
    );
  }
}
