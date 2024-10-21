class TodoModel {
  String uppdrag;
  bool checked;
  String id;

  TodoModel(this.uppdrag, this.checked, this.id);


  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(json['title'], json['done'], json['id']);
  }
}
