import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/View/Login/login_page.dart';
import 'package:firebase_project/View/Register/register_page.dart';
import 'package:firebase_project/View/Home%20Page/homepage.dart';
import 'package:firebase_project/View/Users%20List/user_list.dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:firebase_project/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return UserList();
      //       } else {
      //         return LoginPage();
      //       }
      //     }),
      home: SplashScreen(),
    );
  }
}
