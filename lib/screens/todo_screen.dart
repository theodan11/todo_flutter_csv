import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_flutter/screens/todo_create.dart';
import 'package:todo_flutter/services/csv_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreen();
}

class _TodoScreen extends State<TodoScreen> {
  CSVService csvService = CSVService();
  List<List<dynamic>> list = [];

  Future<void> loadCSV() async {
    csvService.createCsv();
    list = await csvService.loadCSV();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        actions: [
          IconButton(
              onPressed: () async => {
                    setState(() {
                      loadCSV();
                      // print("refreshed pressed and list is $list");
                    })
                  },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                setState(() {
                  csvService.deleteTodos();
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              List<dynamic> listitem = list[index];
              return Card(
                color: index == 0
                    ? Colors.blue.shade900
                    : const Color.fromARGB(255, 82, 134, 177),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(
                      //   "${listitem[0]}",
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${listitem[1]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Text(
                      //   "${listitem[3]}",
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${listitem[4]}",
                        style: const TextStyle(color: Colors.white),
                      ),

                      if (index != 0)
                        IconButton(
                            onPressed: () {
                              setState(() {
                                csvService.deleteSingleTodo(listitem[0]);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                    ],
                  ),
                ),
              );
            }),
      )),
      floatingActionButton: IconButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoCreate(),
                  ),
                ),
                // checkDir()
              },
          icon: const Icon(Icons.add)),
    );
  }
}

extension on Future<Directory?> {
  get path => null;
}
