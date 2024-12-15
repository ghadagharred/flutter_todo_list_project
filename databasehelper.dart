import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'new_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Création des tables
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            date TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertTodo(Map<String, dynamic> todo) async {
    try {
      final db = await database;
      return await db.insert('todos', todo);
    } catch (e) {
      print("Erreur lors de l'insertion d'une tâche : $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final db = await database;
      return await db.query('todos');
    } catch (e) {
      print("Erreur lors de la récupération des tâches : $e");
      return [];
    }
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
