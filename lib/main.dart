import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:distress_assistant/loginPage.dart';


User user;
var a=7;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("error: $snapshot.error"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {

                    User user = snapshot.data;

                    if (user == null) {
                      return loginPage();
                    } else {
                      return mainScreen();
                    }
                  }

                  return Scaffold(
                    body: Center(
                      child: Text('Checking Authentication'),
                    ),
                  );
                });
          }
          return Scaffold(
            body: Center(
              child: Text('Connecting to app...'),
            ),
          );
        });
  }
}
