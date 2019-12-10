import 'package:flutter/material.dart';

import 'package:fbla/screens/all.dart';
import 'package:fbla/screens/specific/joinHome.dart';

// TODO: Add 'Hero' Class to all the appbars
// TODO: Add splash screen as loading screen
// TODO: Rewrite all the code & make code easier and more beautiful to read.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _SelectNav(),
      theme: ThemeData(
        fontFamily: 'RaleWay',
        primaryColor: Color.fromRGBO(0, 30, 96, 1), // Offical Color
        accentColor: Color.fromRGBO(0, 173, 230, 1), // Secondary Color
        // Color.fromRGBO(0, 0, 0, 1), // Black
        // Color.fromRGBO(0, 51, 160, 1), // PBL Blue
        // Color.fromRGBO(191, 13, 62, 1), // PBL Red
      ),
      routes: <String, WidgetBuilder>{
        // Part of Nav
        'attendence': (BuildContext context) => Attendence('Attendence'),
        'calendar': (BuildContext context) => Calendar('Calendar'),
        'contact': (BuildContext context) => Contact('Contact Us'),
        'form': (BuildContext context) => JoinForm('Form'),
        'officers': (BuildContext context) => Officers('Officers'),
        'questions': (BuildContext context) => Question('Q&A'),
        'social': (BuildContext context) => Social('Social Media'),

        // Part of Opening Screen
        'home': (BuildContext context) => Home(),
        'admin': (BuildContext context) => Admin(),

        // Part of home
        'joinHome': (BuildContext context) => JoinHome('Join FBLA!'),
      },
    );
  }
}

class _SelectNav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(50.0),
                  ),
                  Text(
                      'Please choose, if you are unsure, then select student.'),
                  Divider(),
                  FlatButton(
                    child: Text('Student'),
                    onPressed: () async {
                      Navigator.of(context).pushNamed('home');
                    },
                  ),
                  FlatButton(
                    child: Text('Administrator'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('admin');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}