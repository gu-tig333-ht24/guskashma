import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'new_class.dart';
import './add_to_list.dart';
import './api.dart';

void main() {
  Todo state = Todo("", false, "");
  runApp(ChangeNotifierProvider(
    create: (context) => state,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(), 
    );
  }
}


class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTodosFromServer(); 
    });
  }

  void _loadTodosFromServer() async {
    final provid = Provider.of<Todo>(context, listen: false);
    List<Todo> todosFromServer = await getFromServer(); 
    provid.updateList(todosFromServer); // Update the list in the Todo model
  }

  @override
  Widget build(BuildContext context) {
    final provid = Provider.of<Todo>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG333 TODO"),
        backgroundColor: Colors.pink,
        actions: [
          PopupMenuButton(onSelected: (value) {
            provid.changeFilter(value);
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: "All", child: Text("All")),
              PopupMenuItem(value: "Done", child: Text("Done")),
              PopupMenuItem(value: "Undone", child: Text("Undone")),
            ];
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: provid.getList.length,
                itemBuilder: (context, index) {
                  final item = provid.getList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item.checked,
                      onChanged: (bool? value) {
                        setState(() {
                          provid.getList[index].checked = value!;
                          provid.uppdateTodO(value, item.id, item.uppdrag); // Corrected method name
                        });
                      },
                    ),
                    title: Text(
                      item.uppdrag,
                      style: TextStyle(
                          decoration: item.checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provid.deleteTodo(item.id); // Delete item
                        },
                        icon: Icon(Icons.cancel)),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddToList()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
