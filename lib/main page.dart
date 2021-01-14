import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lokaarpan/pages/articles.dart';
import 'package:lokaarpan/pages/category_articles.dart';
import 'package:lokaarpan/pages/jobs.dart';
import 'package:lokaarpan/pages/local_articles.dart';
import 'package:lokaarpan/pages/search.dart';
import 'package:lokaarpan/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Firebase Cloud Messeging setup
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    Articles(),
    Search(),
    LocalArticles(),
    Jobs(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
  }

  startFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = prefs.getInt(key) ?? 0;
    if (value == 1) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  message["notification"]["title"],
                  style: TextStyle(fontFamily: "Soleil", fontSize: 18),
                ),
                content: Text(message["notification"]["body"]),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("Dismiss"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        onLaunch: (Map<String, dynamic> message) async {
          // print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          // print("onResume: $message");
        },
      );
      _firebaseMessaging.getToken().then((token) {
        // print("Firebase Token:" + token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.deepOrangeAccent,
        items: <Widget>[
          Icon(Icons.list, size: 30, semanticLabel: "news",),
          Icon(Icons.search, size: 30),
          Icon(Icons.people_outline, size: 30),
          Icon(Icons.account_tree_sharp),
          Icon(Icons.settings, size: 30,)
        ],
        onTap: _onItemTapped,
        height: 50,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
