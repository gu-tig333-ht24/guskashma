import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './todo_class.dart';

class AddToList extends StatefulWidget {
  const AddToList({super.key});

  @override
  State<AddToList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddToList> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provid_2 = Provider.of<Todo>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("TIG333 TODO"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: "What are you going to do ?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await addToServer(textEditingController.text);
                List<Todo> respone = await getFromServer();
                provid_2.updateList(respone);
                Navigator.pop(context);
              },
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50), backgroundColor: Colors.pink),
            )
          ],
        ));
  }
}

