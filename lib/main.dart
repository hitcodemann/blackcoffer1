import 'package:blackcoffer/screens/home_screen.dart';
import 'package:blackcoffer/screens/login_screen.dart';
import 'package:blackcoffer/screens/splash_screen.dart';
import 'package:blackcoffer/utils/custom_scrool_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAabJ83tc4r_S8QCN0VaAZry1nXSZChBJk",
      projectId: "blackcoffer-557ad",
      storageBucket: "blackcoffer-557ad.appspot.com",
      messagingSenderId: "715478055106",
      appId: "1:715478055106:web:1f8139d734d308dc65635b",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlackCoffer',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade200),
        fontFamily: "SegSemiBold",

      ),
      home: const HomeScreen(),
    );
  }
}
