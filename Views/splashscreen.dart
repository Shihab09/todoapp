import 'package:flutter/material.dart';
import 'package:todo_link3_shihab/Views/profilepage.dart';
import 'dart:async';

import 'homepage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add a delay of 3 seconds before navigating to the main screen
    Timer( Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.PNG'),
            fit: BoxFit.fill, // Make the image stretch to fill the container
          ),
        ),
      ),
    );
  }
}
