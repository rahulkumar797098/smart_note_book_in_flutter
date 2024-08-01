import 'package:flutter/material.dart';
import 'package:smart_note/database/local/data_base_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataBaseHelper? mainDB;
  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    mainDB = DataBaseHelper.instance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await mainDB!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 30,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                final note = allNotes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      note[DataBaseHelper.columnNoteTitle],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note[DataBaseHelper.columnNoteMessage]),
                    trailing: const Column(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "No Notes Found!",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
    );
  }
}
