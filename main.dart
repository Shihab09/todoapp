import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'Views/homepage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(MyApp());
  tz.initializeTimeZones();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize local notifications
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shihab's TODO APP",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      // home: ListPage(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
    );
  }
}
//
// class ListPage extends StatefulWidget {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   ListPage({required this.flutterLocalNotificationsPlugin});
//
//   @override
//   _ListPageState createState() => _ListPageState();
// }
//
// class _ListPageState extends State<ListPage> {
//   List<Map<String, dynamic>> lists = [];
//   TextEditingController _listController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Lists'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: lists.isEmpty
//                 ? Center(child: Text('No lists added yet'))
//                 : ListView.builder(
//               itemCount: lists.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(lists[index]['title']),
//                   subtitle: Text('${lists[index]['tasks'].length} tasks'),
//                   trailing: Icon(Icons.arrow_forward),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TaskPage(
//                           listIndex: index,
//                           list: lists[index],
//                           flutterLocalNotificationsPlugin: widget.flutterLocalNotificationsPlugin,
//                         ),
//                       ),
//                     ).then((_) => setState(() {}));
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddListDialog(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showAddListDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add New List'),
//           content: TextField(
//             controller: _listController,
//             decoration: InputDecoration(hintText: 'Enter list title'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _listController.clear();
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   lists.add({'title': _listController.text, 'tasks': []});
//                 });
//                 _listController.clear();
//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class TaskPage extends StatefulWidget {
//   final int listIndex;
//   final Map<String, dynamic> list;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   TaskPage({required this.listIndex, required this.list, required this.flutterLocalNotificationsPlugin});
//
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }
//
// class _TaskPageState extends State<TaskPage> {
//   TextEditingController _taskController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.list['title']),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: widget.list['tasks'].isEmpty
//                 ? Center(child: Text('No tasks added yet'))
//                 : ListView.builder(
//               itemCount: widget.list['tasks'].length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(widget.list['tasks'][index]['task']),
//                   subtitle: Text(widget.list['tasks'][index]['notes']),
//                   trailing: Text(widget.list['tasks'][index]['dateTime'] != null
//                       ? DateFormat.yMMMd().add_jm().format(
//                     widget.list['tasks'][index]['dateTime'],
//                   )
//                       : ''),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TaskDetailPage(
//                           task: widget.list['tasks'][index],
//                           onDelete: () {
//                             setState(() {
//                               widget.list['tasks'].removeAt(index);
//                             });
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddTaskDialog(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showAddTaskDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AddTaskDialog(
//           onTaskAdded: (String task, String? notes, DateTime? dateTime, bool remindMe) {
//             setState(() {
//               widget.list['tasks'].add({
//                 'task': task,
//                 'notes': notes ?? '',
//                 'dateTime': dateTime,
//                 'remindMe': remindMe,
//               });
//               // If remind me is checked and dateTime is set, schedule a notification
//               if (remindMe && dateTime != null) {
//                 _scheduleNotification(task, dateTime);
//               }
//             });
//           },
//         );
//       },
//     );
//   }
//
//   // Schedule a notification
//   Future<void> _scheduleNotification(String task, DateTime dateTime) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       channelDescription: 'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//
//     await widget.flutterLocalNotificationsPlugin.schedule(
//       0, // Notification ID
//       'Task Reminder',
//       'Reminder for task: $task',
//       dateTime,
//       platformChannelSpecifics,
//     );
//   }
// }
//
// class AddTaskDialog extends StatefulWidget {
//   final Function(String, String?, DateTime?, bool) onTaskAdded;
//
//   AddTaskDialog({required this.onTaskAdded});
//
//   @override
//   _AddTaskDialogState createState() => _AddTaskDialogState();
// }
//
// class _AddTaskDialogState extends State<AddTaskDialog> {
//   TextEditingController _taskController = TextEditingController();
//   TextEditingController _notesController = TextEditingController();
//   DateTime? _selectedDateTime;
//   bool _remindMe = false;
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null) {
//       final TimeOfDay? timePicked = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//       if (timePicked != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//               picked.year, picked.month, picked.day, timePicked.hour, timePicked.minute);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add New Task'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _taskController,
//               decoration: InputDecoration(hintText: 'Enter task description'),
//             ),
//             SizedBox(height: 10),
//             ListTile(
//               title: Text(_selectedDateTime == null
//                   ? 'Pick due date and time'
//                   : DateFormat.yMMMd().add_jm().format(_selectedDateTime!)),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () {
//                 _selectDateTime(context);
//               },
//             ),
//             TextField(
//               controller: _notesController,
//               decoration: InputDecoration(hintText: 'Enter notes (optional)'),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Remind Me'),
//                 Checkbox(
//                   value: _remindMe,
//                   onChanged: (value) {
//                     setState(() {
//                       _remindMe = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             widget.onTaskAdded(
//               _taskController.text,
//               _notesController.text.isNotEmpty ? _notesController.text : null,
//               _selectedDateTime,
//               _remindMe,
//             );
//             Navigator.pop(context);
//           },
//           child: Text('Add Task'),
//         ),
//       ],
//     );
//   }
// }
//
// class TaskDetailPage extends StatelessWidget {
//   final Map<String, dynamic> task;
//   final VoidCallback onDelete;
//
//   TaskDetailPage({required this.task, required this.onDelete});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(task['task']),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               onDelete(); // Trigger the task deletion
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Task:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(task['task']),
//             SizedBox(height: 10),
//             Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(task['notes'] ?? 'No notes'),
//             SizedBox(height: 10),
//             Text('Due Date:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(task['dateTime'] != null
//                 ? DateFormat.yMMMd().add_jm().format(task['dateTime'])
//                 : 'No due date'),
//             SizedBox(height: 10),
//             Text('Remind Me:', style: TextStyle(fontWeight: FontWeight.bold)),
//             task['remindMe']
//                 ? Icon(Icons.check, color: Colors.green)
//                 : Icon(Icons.clear, color: Colors.red),
//           ],
//         ),
//       ),
//     );
//   }
// }
