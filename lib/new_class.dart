import 'package:flutter/material.dart';
import './api.dart';


class Todo extends ChangeNotifier {
  String uppdrag;
  bool checked;
  String id;
  Todo(this.uppdrag, this.checked, this.id);

  List<Todo> list = [];
  String the_filter = "";

  void addToList(Todo item) {
    list.add(item);
    notifyListeners();
  }


  List<Todo> get getList {
    if (the_filter == "Done") {
      return list.where((item) => item.checked == true).toList();
    } else if (the_filter == "Undone") {
      return list.where((item) => item.checked == false).toList();
    }
    return list;
  }

  void changeFilter(String newfilter) {
    the_filter = newfilter;
    notifyListeners();
  }

  void updateList(List<Todo> newlist) {
    list = newlist;
    notifyListeners();
  }

  void deleteTodo(String id) async {
    await deleteFromServer(id);
    list.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void uppdateTodO(bool check, String id, String title) async {
    await updateServer(check, id, title);
    notifyListeners();
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['title'], json['done'], json['id']);
  }
}
