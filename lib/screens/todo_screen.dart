import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:todo_flutter/screens/todo_create.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreen();
}

class _TodoScreen extends State<TodoScreen> {
  List<List<dynamic>> list = [];

  void loadCSV() async {
    String todolist = await rootBundle.loadString('assets/todo_list.csv');
    list = const CsvToListConverter().convert(todolist);
    // print(list);
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
                    children: [
                      Text(
                        "${listitem[0]}",
                        style: const TextStyle(color: Colors.white),
                      ),
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
                      Text(
                        "${listitem[3]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${listitem[4]}",
                        style: const TextStyle(color: Colors.white),
                      ),
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
              },
          icon: const Icon(Icons.add)),
    );
  }
}
