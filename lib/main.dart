import 'package:flutter/material.dart';
import 'mainScreen.dart';
import 'RegistrationScreen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: mainScreen.id,
      routes: {
        mainScreen.id: (context) => mainScreen(),
        registrationScreen.id: (context) => registrationScreen(),
      },
    ),
  );
}
