import 'dart:async';

import 'package:firebase_project/View/Login/login_page.dart';
import 'package:firebase_project/View/Users%20List/user_list.dart';
import 'package:firebase_project/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/Home Page/cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashData() async {
     token =await LocalStorage.getData();
     print("????????????////////$token");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => token == null ? LoginPage() : UserList(),
    ));
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),splashData);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: Text("WELCOME",),),
    );
  }
}
