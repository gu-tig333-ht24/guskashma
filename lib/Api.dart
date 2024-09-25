import 'package:http/http.dart' as http;
import './main.dart';
import 'dart:convert';

Future<void> addToServer(String uppdrag) async {
  await http.post(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos?key=59f21635-eb90-491e-8439-5a68c83a72c9"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"title": uppdrag, "done": false}));
}

Future<List<Todo>> getFromServer() async {
  final http.Response response = await http.get(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos?key=59f21635-eb90-491e-8439-5a68c83a72c9"));
  List<dynamic> listDeco = jsonDecode(response.body);
  return listDeco.map((item) => Todo.fromJson(item)).toList();
}

Future<void> deleteFromserver(String id) async {
  await http.delete(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=59f21635-eb90-491e-8439-5a68c83a72c9"));
}

Future<void> uppdateServer(bool check, String id, String title) async {
  await http.put(
    Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=59f21635-eb90-491e-8439-5a68c83a72c9"),
    body: jsonEncode({"title": title, "done": check}),
    headers: {'Content-Type': 'application/json'},
  );
}
