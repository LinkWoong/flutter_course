import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

enum AuthMode { SignUp, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
        image: AssetImage('assets/823353.png'));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      maxLines: 1,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Email cannot be empty and should be in the correct format';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      autofocus: false,
      obscureText: _authMode == AuthMode.Login ? true : false,
      maxLines: 1,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Password does not match';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'password'),
      obscureText: _authMode == AuthMode.Login ? true : false, // hide the input
      autofocus: false,
      controller: _passwordTextController,
      maxLines: 1,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Password cannot be empty and password minimum length is 5';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      title: Text('Accept terms'),
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  void _submitForm(Function login, Function singup) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    if (_authMode == AuthMode.Login) {
      successInformation =
          await login(_formData['email'], _formData['password']);
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      // only when signup successful then navigate to products page
      successInformation =
          await singup(_formData['email'], _formData['password']);
    }
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error occurred'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  // change ListTile to SingleChildScrollView
                  child: Container(
                    width: targetWidth, // 80% of device width
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextField(),
                        _buildPasswordTextField(),
                        _authMode == AuthMode.SignUp
                            ? _buildPasswordConfirmTextField()
                            : Container(),
                        _buildAcceptSwitch(),
                        // add some space
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          child: Text(
                              'Switch to ${_authMode == AuthMode.Login ? 'SignUp' : 'Login'}'),
                          onPressed: () {
                            setState(() {
                              _authMode = _authMode == AuthMode.Login
                                  ? AuthMode.SignUp
                                  : AuthMode.Login;
                            });
                          },
                        ),
                        // navigate to products page
                        Center(
                          child: ScopedModelDescendant<MainModel>(builder:
                              (BuildContext context, Widget child,
                                  MainModel model) {
                            return RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text('Login'),
                                onPressed: () =>
                                    _submitForm(model.login, model.signup));
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
