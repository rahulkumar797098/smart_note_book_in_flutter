import 'package:flutter/material.dart';
import 'package:smart_note/database/local/data_base_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  late final DataBaseHelper mainDB;
  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    mainDB = DataBaseHelper.instance;
    getNotes();
  }

  Future<void> getNotes() async {
    final notes = await mainDB.getAllNotes();
    setState(() {
      allNotes = notes;
    });
  }

  void _showEditBottomSheet(Map<String, dynamic> note) {
    titleController.text = note[DataBaseHelper.columnNoteTitle];
    messageController.text = note[DataBaseHelper.columnNoteMessage];

    showModalBottomSheet(
      elevation: 15,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Update Notes",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    label: const Text("Title"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    label: const Text("Message"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(width: 1, color: Colors.red),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        mainDB.updateNote(
                          id: note[DataBaseHelper.columnNoteSno],
                          title: titleController.text,
                          message: messageController.text,
                        );
                        getNotes();
                        titleController.clear();
                        messageController.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.green,
                        elevation: 8,
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            elevation: 15,
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Add Notes",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: false,
                          border: InputBorder.none,
                          label: const Text("Title"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          filled: false,
                          border: InputBorder.none,
                          label: const Text("Message"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(width: 1, color: Colors.red),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontSize: 22, color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              mainDB.addNote(
                                title: titleController.text,
                                message: messageController.text,
                              );
                              getNotes();
                              titleController.clear();
                              messageController.clear();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadowColor: Colors.green,
                              elevation: 8,
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 30,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              "Notes",
              style: TextStyle(fontSize: 25),
            ),
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
            elevation: 5,
            shadowColor: Colors.amberAccent,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 150, // Set a default height for the card
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note[DataBaseHelper.columnNoteTitle],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                note[DataBaseHelper.columnNoteMessage],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Column(
                          children: [
                            // Delete icon
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    mainDB.deleteNote(
                                        note[DataBaseHelper.columnNoteSno]);
                                    getNotes();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            // Edit icon
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _showEditBottomSheet(note);
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
