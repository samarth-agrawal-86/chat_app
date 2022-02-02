import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(
    String email,
    String password,
    String username,
    bool _isLogin,
  ) handleSubmit;

  final isLoading;
  AuthForm({required this.handleSubmit, required this.isLoading});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPwd = '';

  void _handleSignUp() {
    FocusScope.of(context).unfocus();
    var _form = _formKey.currentState;
    var _isValid = _form!.validate();
    if (_isValid) {
      _form.save();
    }
    widget.handleSubmit(_userEmail, _userPwd, _userName, _isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  if (_isLogin == false)
                    TextFormField(
                      key: ValueKey('name'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('pwd'),
                    validator: (value) {
                      if (value == null || value.length < 7) {
                        return 'Password should be atleast 7 characters';
                      }
                    },
                    onSaved: (newValue) {
                      _userPwd = newValue!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 35),
                  if (widget.isLoading == true) CircularProgressIndicator(),
                  if (widget.isLoading == false)
                    ElevatedButton(
                      onPressed: () {
                        _handleSignUp();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  if (widget.isLoading == false)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
