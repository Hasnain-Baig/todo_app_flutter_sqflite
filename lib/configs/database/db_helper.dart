import 'package:crud_flutter_local_database/models/todosModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database db;
  final String tableName = "todos";
  final String columnId = "_id";
  final String columnItem = "item";

  Future<void> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "todos.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'Text NOT Null';

    return await db.execute('''
CREATE TABLE $tableName(
  ${columnId} $idType,
  ${columnItem} $textType
)
''');
  }

  Future<void> insertTodo(Todo todo) async {
    try {
      db.insert(tableName, todo.toMap());
    } catch (e) {
      print("Insert error : $e");
    }
  }

  Future<List> getAllTodos() async {
    final List<Map<String, dynamic>> todos = await db.query(tableName);
    return List.generate(todos.length, (i) {
      return Todo(id: todos[i][columnId], item: todos[i][columnItem]);
    });
  }

  Future<int> deleteAllTodos() async {
    return await db.rawDelete("DELETE FROM $tableName");
  }

  Future<int> deleteTodo(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateTodo(Todo todo) async {
    return await db.update(tableName, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }
}
