
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  // Private constructor for singleton pattern
  DataBaseHelper._privateConstructor();

  // Singleton instance
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  // Table and column names
  static final String tableNote = "noteData";
  static final String columnNoteSno = "s_no";
  static final String columnNoteTitle = "title";
  static final String columnNoteMessage = "message";

  // Database instance
  Database? _database;

  // Getter for database
  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _openDb();
    return _database!;
  }

  // Open database
  Future<Database> _openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, "notes.db");
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableNote(
          $columnNoteSno INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnNoteTitle TEXT,
          $columnNoteMessage TEXT
        )
      ''');
    });
  }

  // Insert a new note
  Future<int> addNote({
    required String title,
    required String message,
  }) async {
    final db = await _db;
    return await db.insert(
      tableNote,
      {
        columnNoteTitle: title,
        columnNoteMessage: message,
      },
    );
  }

  // Get all notes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await _db;
    return await db.query(tableNote);
  }

  // Update a note
  Future<int> updateNote({
    required int id,
    required String title,
    required String message,
  }) async {
    final db = await _db;
    return await db.update(
      tableNote,
      {
        columnNoteTitle: title,
        columnNoteMessage: message,
      },
      where: '$columnNoteSno = ?',
      whereArgs: [id],
    );
  }

  // Delete a note
  Future<int> deleteNote(int id) async {
    final db = await _db;
    return await db.delete(
      tableNote,
      where: '$columnNoteSno = ?',
      whereArgs: [id],
    );
  }

  // Search notes by title
  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    final db = await _db;
    return await db.query(
      tableNote,
      where: '$columnNoteTitle LIKE ?',
      whereArgs: ['%$query%'],
    );
  }
}
