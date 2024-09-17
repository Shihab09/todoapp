// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'listpage.dart';


class ProfilePage extends StatelessWidget {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your image
                ),
                SizedBox(width: 16),
        
                // Name and Task Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Syed Shihab Uddin Sultan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    // SizedBox(child: ListPage(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin)),
                    Text(
                      'Manage your Tasks List',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(child: ListPage(
                flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin
            ),
              height: MediaQuery.of(context).size.height/1.5,
            ),
          // Add any additional widgets for further content below.
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ListPage(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin)));
      //   },
      //   backgroundColor: Colors.indigo[200],
      //   hoverColor: Colors.blueAccent[400],
      //   child: Icon(Icons.add),
      // ),
    );
  }

}