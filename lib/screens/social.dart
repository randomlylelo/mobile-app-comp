import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fbla/widgets/help.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Links to Social Media

class Social extends StatelessWidget {
  final String title;

  Social(this.title);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Help(
              'This page is used for links for to FBLA Social Media and website, contains FBLA Chapter links',
              'To use this page, all you have to do press on the buttons \'Visit\' and for the social media, all you have to press is the selected social media icons.'),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(0, 51, 160, .7),
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Color.fromRGBO(0, 173, 230, 1),
                      child: Text(
                        'Mater Lakes FBLA Website',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () => _launchURL(
                          'https://www.materlakes.org/apps/pages/index.jsp?uREC_ID=106549&type=d&termREC_ID=&pREC_ID=staff'),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Color.fromRGBO(0, 30, 96, 1),
                      child: Text(
                        'Offical FBLA Website',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _launchURL('https://www.fbla-pbl.org/'),
                    ),
                  ),
                  Expanded(
                    child: WebView(
                      initialUrl: 'https://twitter.com/FBLA_National/',
                      javascriptMode: JavascriptMode.disabled,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Follow FBLA\'s Social Media!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '(Press the buttons below)',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        //padding: EdgeInsets.all(12),
        color: Color.fromRGBO(0, 173, 230, 1),
        height: MediaQuery.of(context).size.height * .10,
        child: Row(
          children: <Widget>[
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .20,
              height: 100.0,
              child: FlatButton(
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.white,
                ),
                onPressed: () =>
                    _launchURL('http://www.facebook.com/FutureBusinessLeaders'),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .20,
              height: 100.0,
              child: FlatButton(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                      ),
                      Text(
                        'FBLA',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () =>
                    _launchURL('https://twitter.com/FBLA_National'),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .20,
              height: 100.0,
              child: FlatButton(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.white,
                      ),
                      Text(
                        'PBL',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () => _launchURL('https://twitter.com/PBL_National'),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .20,
              height: 100.0,
              child: FlatButton(
                child: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
                onPressed: () => _launchURL('https://instagram.com/fbla_pbl/'),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .20,
              height: 100.0,
              child: FlatButton(
                child: Icon(
                  FontAwesomeIcons.linkedinIn,
                  color: Colors.white,
                ),
                onPressed: () =>
                    _launchURL('http://www.linkedin.com/groups?gid=106458'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
