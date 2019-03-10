import 'package:flutter/material.dart';

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
      validator: (String value){
        if(value.isEmpty
            || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)){
          return 'Email cannot be empty and should be in the correct format';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'password'),
      obscureText: true, // hide the input
      autofocus: false,
      maxLines: 1,
      validator: (String value){
        if(value.isEmpty || value.length < 5){
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

  void _submitForm() {
    if(!_formKey.currentState.validate() || !_formData['acceptTerms']){
      return;
    }
    print(_formData);
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/products');
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
              ),
            )));
  }
}
