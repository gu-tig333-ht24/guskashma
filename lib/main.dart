import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './todo_list_model.dart';
import './add_to_list.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoListModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: To_DO_List(),
    );
  }
}

class To_DO_List extends StatefulWidget {
  @override
  _To_DO_ListState createState() => _To_DO_ListState();
}

class _To_DO_ListState extends State<To_DO_List> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoListModel>(context, listen: false).loadTodosFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final provid = Provider.of<TodoListModel>(context);
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
      body: ListView.builder(
        itemCount: provid.getList.length,
        itemBuilder: (context, index) {
          final item = provid.getList[index];
          return ListTile(
            leading: Checkbox(
              value: item.checked,
              onChanged: (bool? value) {
                provid.updateTodo(value!, item.id, item.uppdrag);
              },
            ),
            title: Text(
              item.uppdrag,
              style: TextStyle(
                decoration: item.checked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                provid.removeFromList(item.id);
              },
              icon: Icon(Icons.cancel),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddToList()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
