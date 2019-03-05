import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _usernameVal = '';
  String _passwordVal = '';
  bool _acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              // username input field
              TextField(
                decoration: InputDecoration(labelText: 'username'),
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                maxLines: 1,
                onChanged: (String value) {
                  setState(() {
                    _usernameVal = value;
                  });
                },
              ),
              // password input field
              TextField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true, // hide the input
                autofocus: false,
                maxLines: 1,
                onChanged: (String value) {
                  setState(() {
                    _passwordVal = value;
                  });
                },
              ),
              // Add a switch
              SwitchListTile(
                title: Text('Accept terms'),
                value: _acceptTerms,
                onChanged: (bool value) {
                  setState(() {
                    _acceptTerms = value;
                  });
                },
              ),
              // add some space
              SizedBox(
                height: 10.0,
              ),
              // navigate to products page
              Center(
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () {
                      print(_usernameVal);
                      print(_passwordVal);
                      Navigator.pushReplacementNamed(
                          context, '/products'); // route '/' registered
                    }),
              )
            ],
          ),
        ));
  }
}
