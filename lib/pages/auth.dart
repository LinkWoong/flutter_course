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

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
        image: AssetImage('assets/823353.png'));
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      maxLines: 1,
      onChanged: (String value) {
        setState(() {
          _usernameVal = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'password'),
      obscureText: true, // hide the input
      autofocus: false,
      maxLines: 1,
      onChanged: (String value) {
        setState(() {
          _passwordVal = value;
        });
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      title: Text('Accept terms'),
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  void _submitForm() {
    print(_usernameVal);
    print(_passwordVal);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidgth =  deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: _buildBackgroundImage(),
            ),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                // change ListTile to SingleChildScrollView
                child: Container(
                  width: targetWidgth, // 80% of device width
                  child: Column(
                    children: <Widget>[
                      // username input field
                      _buildEmailTextField(),
                      // password input field
                      _buildPasswordTextField(),
                      // Add a switch
                      _buildAcceptSwitch(),
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
                            onPressed: _submitForm),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
