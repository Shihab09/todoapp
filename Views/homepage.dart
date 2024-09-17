import 'package:flutter/material.dart';
import 'package:todo_link3_shihab/Views/profilepage.dart';
import 'package:todo_link3_shihab/Views/sensorscreen.dart';
import 'package:todo_link3_shihab/Views/splashscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Button (A To-Do List)
            GestureDetector(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
              },
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'A To-Do List',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between the buttons

            // Second Button (Sensor Tracking)
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SensorTrackingPage()));
                // SensorTrackingPage// Add functionality for the Sensor Tracking button
              },
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Sensor Tracking',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}