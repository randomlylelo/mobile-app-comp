import 'package:flutter/material.dart';
import 'package:fbla/widgets/global.dart' as globals;

import 'package:fbla/widgets/help.dart';

class Admin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminState();
}

// TODO: Get data from servers / local files.

enum Screen { login, register }

class _AdminState extends State<Admin> {
  // Declare Variables
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _nameFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();

  // Set default to login.
  Screen _form = Screen.login;

  _AdminState() {
    // Email Listener
    _emailFilter.addListener(() {
      if (_emailFilter.text.isEmpty) {
        globals.email = '';
      } else {
        globals.email = _emailFilter.text;
      }
    });
    // Name Listener
    _nameFilter.addListener(() {
      if (_nameFilter.text.isEmpty) {
        globals.name = '';
      } else {
        globals.name = _nameFilter.text;
      }
    });
    // Password Listener
    _passwordFilter.addListener(() {
      if (_passwordFilter.text.isEmpty) {
        globals.password = '';
      } else {
        globals.password = _passwordFilter.text;
      }
    });
  }

  void _screenChange() {
    setState(() {
      if (_form == Screen.register) {
        _form = Screen.login;
      } else {
        _form = Screen.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Login!'),
        actions: <Widget>[
          Help(
            'This is a login page for the officers and advisors of the FBLA Chapter.',
            'To use this page all you have to do is type in your email and password, if you don\'t have account or forgot your password click the respective buttons. ',
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    if (_form == Screen.login) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: _emailFilter,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                controller: _passwordFilter,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                obscureText: true,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: _emailFilter,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                controller: _nameFilter,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                controller: _passwordFilter,
                decoration: InputDecoration(
                    labelText: 'Password', prefixIcon: Icon(Icons.vpn_key)),
                obscureText: true,
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _buildButtons() {
    if (_form == Screen.login) {
      return Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                globals.email = _emailFilter.text;
                globals.password = _passwordFilter.text;
                AlertDialog dialog;
                if (globals.isAccount(globals.email, globals.password)) {
                  dialog = AlertDialog(
                    content: Text('Login Successful.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          globals.name = globals.getUserName(
                              globals.email, globals.password);
                          Navigator.pop(context);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'home', ModalRoute.withName('home'));
                        },
                        child: Text('Okay'),
                      ),
                    ],
                  );
                } else {
                  dialog = AlertDialog(
                    content: Text('Login Failed.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Okay'),
                      ),
                    ],
                  );
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog,
                );
              },
            ),
            FlatButton(
              child: Text('Dont have an account? Tap here to register.'),
              onPressed: _screenChange,
            ),
            FlatButton(
              child: Text('Forgot Password?'),
              onPressed: () {
                AlertDialog dialog = AlertDialog(
                  content: Text('A password request form was sent to the email that you had entered in the login form.'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay'),
                    ),
                  ],
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog,
                );
              },
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Create an Account',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                AlertDialog dialog = AlertDialog(
                  content: Text('Account Created Successfully.'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        globals.email = _emailFilter.text;
                        globals.password = _passwordFilter.text;
                        globals.name = _nameFilter.text;
                        _accPrint();
                        Navigator.pop(context);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'home', ModalRoute.withName('home'));
                      },
                      child: Text('Okay'),
                    ),
                  ],
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog,
                );
              },
            ),
            FlatButton(
              child: Text('Have an account? Click here to login.'),
              onPressed: _screenChange,
            )
          ],
        ),
      );
    }
  }

  void _accPrint() {
    print(
        'Email: ${globals.email}, Password: ${globals.password}, Name: ${globals.name}');
  }

  @override
  void dispose() {
    // Cleaning up Controllers.
    _nameFilter.dispose();
    _passwordFilter.dispose();
    _emailFilter.dispose();
    super.dispose();
  }
}
