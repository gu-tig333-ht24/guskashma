import 'package:http/http.dart' as http;
import 'new_class.dart'; 
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
  
  if (response.statusCode == 200) {
    List<dynamic> listDeco = jsonDecode(response.body);
    return listDeco.map((item) => Todo.fromJson(item)).toList(); // Use TodoModel here
  } else {
    throw Exception('Failed to load todos from server');
  }
}

Future<void> deleteFromServer(String id) async {
  await http.delete(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=59f21635-eb90-491e-8439-5a68c83a72c9"));
}

Future<void> updateServer(bool check, String id, String title) async {
  await http.put(
    Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=59f21635-eb90-491e-8439-5a68c83a72c9"),
    body: jsonEncode({"title": title, "done": check}),
    headers: {'Content-Type': 'application/json'},
  );
}
