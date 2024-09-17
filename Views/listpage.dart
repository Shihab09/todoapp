import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_link3_shihab/Views/taskpage.dart';

class ListPage extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ListPage({required this.flutterLocalNotificationsPlugin});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> lists = [];
  TextEditingController _listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Task Lists :'),
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          Expanded(
            child: lists.isEmpty
                ? Center(child: Text('No Task lists added yet'))
                : ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                return ListTile(

                  title: Text(lists[index]['title']),
                  subtitle: Text('${lists[index]['tasks'].length} tasks'),
                  trailing: Icon(Icons.list),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(
                          listIndex: index,
                          list: lists[index],
                          flutterLocalNotificationsPlugin: widget.flutterLocalNotificationsPlugin,
                        ),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddListDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New List'),
          content: TextField(
            controller: _listController,
            decoration: InputDecoration(hintText: 'Enter list title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _listController.clear();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  lists.add({'title': _listController.text, 'tasks': []});
                });
                _listController.clear();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}