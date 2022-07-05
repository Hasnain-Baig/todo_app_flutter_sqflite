import 'package:crud_flutter_local_database/controller/todosController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodosScreen extends StatelessWidget {
  TodosController _todosController = Get.put(TodosController());

  @override
  Widget build(BuildContext context) {
    TodosController _todosController = Get.put(TodosController());

    return GetBuilder<TodosController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("To Do App"),
              actions: [
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        _todosController.deleteAllTodos();
                      },
                      child: Text("Delete All")),
                )
              ],
            ),
            body: Container(
              child: Column(
                children: [
                  buildInput(context),
                  const SizedBox(
                    height: 30,
                  ),
                  buildTodosFutureList(context),
                ],
              ),
            )),
      );
    });
  }

  Widget buildInput(context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: TextField(
            autofocus: true,
            controller: _todosController.todoController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
              onPressed: () {
                _todosController.isUpdating
                    ? _todosController.updateTodo()
                    : _todosController.insertTodo(context);
              },
              child: Text(
                _todosController.isUpdating ? "Update" : "Add",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget buildTodosFutureList(context) {
    return FutureBuilder(
        future: _todosController.getTodos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return buildTodosListView(context);
          } else {
            return Center(child: Text("No Data Found"));
          }
          return CircularProgressIndicator();
        });
  }

  Widget buildTodosListView(context) {
    return Expanded(
        child: ListView.builder(
            itemCount: _todosController.todos.length,
            itemBuilder: (context, index) {
              var id = _todosController.todos[index].id;
              var item = _todosController.todos[index].item;

              return Container(
                key: Key(id.toString()),
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 15, 98, 167)),
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _todosController.editTodo(id, item);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _todosController.deleteTodo(id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
