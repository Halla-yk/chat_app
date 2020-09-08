import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFun);
  final void Function(String email,String username,String password,bool isLogin) submitFun;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String username = "";
  String password = "";
  bool _isLogin = true;

  void _trySubmit() {
    final isValidate = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValidate) {
      _formKey.currentState.save();
      widget.submitFun(email,username,password,_isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 45,),
                  FlatButton.icon(onPressed: (){}, icon: Icon(Icons.camera_alt), label: null),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    onSaved: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'sign up'),
                    onPressed: () {
                      _trySubmit();
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton(
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'I already have an account'),
                    onPressed: () {setState(() {
                      _isLogin = !_isLogin;
                    });},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
