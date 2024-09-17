import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String, String?, DateTime?, bool) onTaskAdded;

  AddTaskDialog({required this.onTaskAdded});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _remindMe = false;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (timePicked != null) {
        setState(() {
          _selectedDateTime = DateTime(
              picked.year, picked.month, picked.day, timePicked.hour, timePicked.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(hintText: 'Enter task description'),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(_selectedDateTime == null
                  ? 'Pick due date and time'
                  : DateFormat.yMMMd().add_jm().format(_selectedDateTime!)),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                _selectDateTime(context);
              },
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(hintText: 'Enter notes (optional)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Remind Me'),
                Checkbox(
                  value: _remindMe,
                  onChanged: (value) {
                    setState(() {
                      _remindMe = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onTaskAdded(
              _taskController.text,
              _notesController.text.isNotEmpty ? _notesController.text : null,
              _selectedDateTime,
              _remindMe,
            );
            Navigator.pop(context);
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }
}