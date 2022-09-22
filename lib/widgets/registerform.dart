import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              child: Text('Test'),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('chats/v89xoHJ6ZYKRHlrG9tNK/messages')
                  .snapshots()
                  .listen((data) {
                data.docs.forEach((element) {
                  print(element.data()['text']);
                });
              });
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
