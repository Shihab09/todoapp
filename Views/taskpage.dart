import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todo_link3_shihab/Views/taskdetailpage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'addtask.dart';

class TaskPage extends StatefulWidget {
  final int listIndex;
  final Map<String, dynamic> list;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TaskPage({required this.listIndex, required this.list, required this.flutterLocalNotificationsPlugin});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list['title']),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.list['tasks'].isEmpty
                ? Center(child: Text('No tasks added yet'))
                : ListView.builder(
              itemCount: widget.list['tasks'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.list['tasks'][index]['task']),
                  subtitle: Text(widget.list['tasks'][index]['notes']),
                  trailing: Text(widget.list['tasks'][index]['dateTime'] != null
                      ? DateFormat.yMMMd().add_jm().format(
                    widget.list['tasks'][index]['dateTime'],
                  )
                      : ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailPage(
                          task: widget.list['tasks'][index],
                          onDelete: () {
                            setState(() {
                              widget.list['tasks'].removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height:50,
        width: 170,
        child: FloatingActionButton(
          onPressed: () {
            _showAddTaskDialog(context);
          },
          child: Text("ADD TASK HERE +"),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          onTaskAdded: (String task, String? notes, DateTime? dateTime, bool remindMe) {
            setState(() {
              widget.list['tasks'].add({
                'task': task,
                'notes': notes ?? '',
                'dateTime': dateTime,
                'remindMe': remindMe,
              });
              // If remind me is checked and dateTime is set, schedule a notification
              if (remindMe && dateTime != null) {
                _scheduleNotification(task, dateTime);
              }
            });
          },
        );
      },
    );
  }

  // Schedule a notification
 void _scheduleNotification(String task, DateTime dateTime) async {
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await widget.flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Task Reminder',
      'Reminder for task: $task',
      tz.TZDateTime.from(dateTime, tz.local),
       platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}