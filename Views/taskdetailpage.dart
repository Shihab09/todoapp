import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onDelete;

  TaskDetailPage({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task['task']),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(); // Trigger the task deletion
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(task['task']),
            SizedBox(height: 10),
            Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(task['notes'] ?? 'No notes'),
            SizedBox(height: 10),
            Text('Due Date:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(task['dateTime'] != null
                ? DateFormat.yMMMd().add_jm().format(task['dateTime'])
                : 'No due date'),
            SizedBox(height: 10),
            Text('Remind Me:', style: TextStyle(fontWeight: FontWeight.bold)),
            task['remindMe']
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.clear, color: Colors.red),
          ],
        ),
      ),
    );
  }
}