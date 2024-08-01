import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_note/database/local/data_base_helper.dart';
import 'home_screen.dart';

class NotesCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesCreateState();
}

class _NotesCreateState extends State<NotesCreate> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  DataBaseHelper? mainDB;

  @override
  void initState() {
    super.initState();
    mainDB = DataBaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Write Notes",
              style: TextStyle(fontSize: 30, color: Colors.black), // Replace appTitle with Colors.black or your preferred color
            ),
            // Icon Check Button
            IconButton(
              onPressed: () async {
                await mainDB?.addNote(
                  title: titleController.text,
                  message: messageController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.check_circle_outline_rounded, size: 40),
              splashColor: Colors.orange,
            ),
          ],
        ),
      ),
      // Body
      body: Column(
        children: [
          // Title Box
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 10),
            child: TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 2,
              autofocus: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Write Title",
                border: InputBorder.none,
              ),
            ),
          ),
          // Message Box
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 10),
            child: TextField(
              controller: messageController,
              minLines: 1,
              maxLines: 10,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Write Notes",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
