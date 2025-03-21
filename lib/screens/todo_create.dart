import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import '../components/text_box.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key});
  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  List<String> menuItems = ['ready', 'completed', 'pending'];
  String? selectedValue = 'ready';
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text("Title"),
                TextBox(
                  textEditingController: titleController,
                  hintText: "Enter title",
                ),
                const Text("Description"),
                TextBox(
                  maxLine: 5,
                  textEditingController: titleController,
                  hintText: "Description",
                ),
                const Text("Status"),
                DropdownButton(
                  value: selectedValue,
                  items: menuItems
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() {
                    selectedValue = item;
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
