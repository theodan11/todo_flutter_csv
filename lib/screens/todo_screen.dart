import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

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
    print(list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                List<dynamic> listitem = list[index];
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(listitem[1]),
                  subtitle: Text(listitem[2]),
                );
              })),
      floatingActionButton:
          IconButton(onPressed: () => {loadCSV()}, icon: const Icon(Icons.add)),
    );
  }
}
