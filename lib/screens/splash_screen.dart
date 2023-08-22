import 'dart:async';
import 'package:blackcoffer/screens/home_screen.dart';
import 'package:blackcoffer/screens/login_screen.dart';
import 'package:blackcoffer/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;

  checkIsLoggedIn() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white)
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: const  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                        Text(
                          "BlackCoffer",
                          style: TextStyle(
                            color: Colors.black87,
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                  ],
                )),
      ),
    );
  }
}
