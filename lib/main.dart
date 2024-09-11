import 'package:flutter/material.dart';
import 'package:template/another_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: to_do(),
    );
  }
}

List<String> Storelist = [
  "Write a book",
  "Watch a tv",
  "Shop groceries",
  "Meditate",
  "Do homework"
];

class to_do extends StatelessWidget {
  const to_do({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(
          child: Text(
            "TIG333 TODO",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: Storelist.length,
                itemBuilder: (context, index) {
                  final index_2 = Storelist[index];
                  return ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    title: Text(index_2),
                    trailing: Icon(Icons.cancel),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnotherPage()));
        },
      ),
    );
  }
}
