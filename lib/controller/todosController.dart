import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/database/db_helper.dart';
import '../models/todosModel.dart';

class TodosController extends GetxController {
  DatabaseHelper _dbHelper = DatabaseHelper();

  List _todos = [];
  List get todos => _todos;

  Color _containerColor = Colors.blue;
  Color get containerColor => _containerColor;

  TextEditingController _todoController = TextEditingController();
  TextEditingController get todoController => _todoController;

  late int _todoId;
  int get todoId => _todoId;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  Future<List> getTodos() async {
    await _dbHelper.initDb();
    List todosList = await _dbHelper.getAllTodos();
    _todos = todosList;
    return todos;
  }

  refreshTodos() async {
    List todosList = await _dbHelper.getAllTodos();
    _todos = todosList;
    update();
    return CircularProgressIndicator();
  }

  insertTodo(context) {
    if (_todoController.text == "") {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (builder) {
            return AlertDialog(
              content: Text("Kindly Fill the TextField First!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Ok"))
              ],
            );
          });
    } else {
      Todo data = Todo(item: todoController.text);
      _dbHelper.insertTodo(data);
      _todoController.clear();
      update();
    }
  }

  updateTodo() {
    Todo data = Todo(id: _todoId, item: _todoController.text);
    _dbHelper.updateTodo(data);
    _todoController.clear();
    _isUpdating = false;
    update();
  }

  deleteTodo(id) {
    _todoId = id;
    _dbHelper.deleteTodo(_todoId);
    _isUpdating = false;
    _containerColor = Colors.blue;
    update();
  }

  deleteAllTodos() {
    _dbHelper.deleteAllTodos();
    _isUpdating = false;
    update();
  }

  editTodo(id, item) {
    _isUpdating = true;
    _todoId = id;
    _todoController.text = item;

    update();
  }
}
