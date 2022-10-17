import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../screens/forgot_password_screen.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);

  final bool _isLoading;

  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
      );
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
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username entered is too short';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least seven characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Create a new account'),
                      onPressed: _trySubmit,
                    ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    TextButton(
                      
                      child: Text(
                          _isLogin ? 'Create a new account' : 'Login instead'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                    TextButton(
                    onPressed: () {
                    Navigator.pushNamed(
                    context,
                    ForgotPassword.id,
                    );
                      },                      
                      child: Text(
                      'Forgot Password?',
                       style: TextStyle(color: Colors.grey, fontSize: 12),
                         ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
