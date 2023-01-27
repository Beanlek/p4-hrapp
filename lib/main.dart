// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'theme/style.dart';
// import 'dart:io';

import 'services/auth.dart';
// import 'splash_screen.dart';
import 'homepage.dart';
import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCkZELp2mkutzBhzkgd48UcUO_1UugeePk",
      projectId: "p4-hrapp",
      messagingSenderId: "590218112695",
      authDomain: "p4-hrapp.firebaseapp.com",
      storageBucket: "p4-hrapp.appspot.com",

      appId: "1:590218112695:web:97f859abe0989e79e22732",
      // appId: "1:590218112695:android:93b3f68b3e817051e22732",

      androidClientId: "590218112695-5v872u6bck188s7c9v3k3jk8p2540k8b.apps.googleusercontent.com",
      // apiKey: apiKey,
      // appId: appId,
      // messagingSenderId: messagingSenderId,
      // projectId: projectId
    )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
        builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'P4 HRAPP',
          theme: mainTheme,//ThemeData(primarySwatch: Colors.blue),
          home: AuthWrapper(),
        );
      }
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HPageAdmin();
              // return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              //   future: adminCheck(),//getUserValue(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return SplashScreen(userValue: 'Admin',);
              //     }else {
              //       return SplashScreen(userValue: 'Students',);
              //     }
              //   }
              // );
            }else {
              return LogInPage();
            }
          },
        ),
      );
  }
}
