import 'package:flutter/material.dart';
import 'package:lokaarpan/common/theme.dart';
import 'package:lokaarpan/main%20page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'lokaarpan',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          accentColor: primaryBackColor,
          textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 17,
                color: Colors.black,
                height: 1.2,
                fontWeight: FontWeight.w500,
                fontFamily: "Soleil",
              ),
              caption: TextStyle(color: Colors.black45, fontSize: 10),
              bodyText1: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              )),
        ),
        home: MyHomePage());
  }
}

