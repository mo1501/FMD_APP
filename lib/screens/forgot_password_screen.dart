import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fmd_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatelessWidget {
  static String id = 'forgot-password';
  var _email = null;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void resetPassword() async {
      final _auth = FirebaseAuth.instance;

      try {
        _formKey.currentState!.save();
        await _auth.sendPasswordResetEmail(email: _email);
        print(_email);
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials';

        if (err.message != null) {
          message = err.message!;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AuthScreen();
        }),
      );
    }

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email Your Email',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                TextFormField(
                  onSaved: (newEmail) {
                    _email = newEmail;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Send Email'),
                  
                  onPressed: () {
                    resetPassword();
                  },
                ),
                ElevatedButton(
                  
                  child: Text('Sign In'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => AuthScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
