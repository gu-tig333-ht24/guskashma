import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("TIG333 TODO"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "What are you going to do ?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(10)),
              height: 30,
              width: 200,
              child: Center(
                child: Text("Add"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
