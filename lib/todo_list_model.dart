import 'package:flutter/material.dart';
import './api.dart';
import './todo_model.dart';

class TodoListModel extends ChangeNotifier {
  List<TodoModel> list = [];
  String filter = "";

  void addToList(TodoModel item) {
    list.add(item);
    notifyListeners();
  }

  void removeFromList(String id) async {
    await deleteFromServer(id);
    list.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  List<TodoModel> get getList {
    if (filter == "Done") {
      return list.where((item) => item.checked == true).toList();
    } else if (filter == "Undone") {
      return list.where((item) => item.checked == false).toList();
    }
    return list;
  }

  void changeFilter(String newFilter) {
    filter = newFilter;
    notifyListeners();
  }

  void updateList(List<TodoModel> newList) {
    list = newList;
    notifyListeners();
  }

  void updateTodo(bool check, String id, String title) async {
    await updateServer(check, id, title);
    var todo = list.firstWhere((item) => item.id == id);
    todo.checked = check;
    todo.uppdrag = title;
    notifyListeners();
  }

  void loadTodosFromServer() async {
    List<TodoModel> todosFromServer = await getFromServer();
    updateList(todosFromServer);
  }
}
