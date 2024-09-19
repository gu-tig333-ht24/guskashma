import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_to_list.dart';

// 97ac9128-1e0b-41de-9d03-cb269c211441
class Todo extends ChangeNotifier {
  String uppdrag;
  bool checked;
  Todo(this.uppdrag, this.checked);

  List<Todo> list = [];
  String the_filter = "";

  void addToList(Todo item) {
    list.add(item);
    notifyListeners();
  }

  void removeFromlist(String uppdrag) {
    list.removeWhere((item) => item.uppdrag == uppdrag);
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

  void updateList(Todo obj) {
    list.add(obj);
    notifyListeners();
  }
}

void main() {
  Todo state = Todo("", false);
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
      home: To_DO_List(),
    );
  }
}

class To_DO_List extends StatefulWidget {
  const To_DO_List({super.key});

  @override
  State<To_DO_List> createState() => _To_DO_ListState();
}

class _To_DO_ListState extends State<To_DO_List> {
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
            print(value);
          }, itemBuilder: (value) {
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
                          provid.removeFromlist(item.uppdrag);
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
