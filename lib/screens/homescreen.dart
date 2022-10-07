import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:fmd_app/screens/forgot_password_screen.dart';
import 'auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _username;
  late File _pickedImage;
  late File _pickedImage2;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error:Image Not Found'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('You have not selected an image'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _pickImageCamera() async {
      final imagePicker = ImagePicker();
      final pickedImageFile =
          await imagePicker.getImage(source: ImageSource.camera);
      setState(() {
        if (pickedImageFile != null) {
          _pickedImage = File(pickedImageFile.path);
        }
      });
      if (_pickedImage != null) {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 80,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage)
                              : null,
                        ),
                        Text('This is an image'),
                      ],
                    ),
                    ),
                  ],
                ),
              );
            });
      } else {
        _showMyDialog();
      }
    }

    void _pickImageGallery() async {
      final imagePicker = ImagePicker();
      final pickedImageFile2 =
          await imagePicker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImageFile2 != null) {
          _pickedImage2 = File(pickedImageFile2.path);
        }
      });
      if (_pickedImage2 != null) {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 80,
                    backgroundImage:
                        _pickedImage2 != null ? FileImage(_pickedImage2) : null,
                  ),
                  Center(
                    child: Text('This is an image'),
                  ),
                ],
              );
            });
      } else {
        _showMyDialog();
      }
    }

    var _auth = FirebaseAuth.instance.currentUser!.uid;
    var authResult = _auth;
    var userDetail;
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth)
        .get()
        .then((DocumentSnapshot doc) {
      userDetail = doc;
      _username = userDetail.data()['username'];
    });
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Homescreen'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ]),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularMenuItem(
                        iconSize: 30.0,
                        icon: Icons.person,
                        color: Theme.of(context).primaryColor,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Center(
                                      heightFactor: 5,
                                      child: Text(
                                        _username,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword(),
                                            ),
                                          );
                                        },
                                        child: Text('Password Reset'))
                                  ],
                                );
                              });
                        }),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularMenuItem(
                      icon: Icons.camera_alt_rounded,
                      color: Theme.of(context).primaryColor,
                      onTap: _pickImageCamera,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularMenuItem(
                      icon: Icons.photo_album_sharp,
                      color: Theme.of(context).primaryColor,
                      onTap: _pickImageGallery,
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularMenuItem(
                      icon: Icons.map_outlined,
                      color: Theme.of(context).primaryColor,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
