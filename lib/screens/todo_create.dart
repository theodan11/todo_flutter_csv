import 'package:flutter/material.dart';
import 'package:todo_flutter/components/button.dart';
import 'package:todo_flutter/services/csv_service.dart';
import '../components/text_box.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({super.key});
  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  CSVService csvService = CSVService();

  List<String> menuItems = ['ready', 'completed', 'pending'];
  String? selectedValue = 'ready';
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Title"),
                const SizedBox(
                  height: 10,
                ),
                TextBox(
                  textEditingController: titleController,
                  hintText: "Enter title",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Description"),
                const SizedBox(
                  height: 10,
                ),
                TextBox(
                  maxLine: 5,
                  textEditingController: descController,
                  hintText: "Description",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Status"),
                const SizedBox(
                  height: 10,
                ),
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
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            onPressed: () {
                              setState(() {
                                csvService.createTodo(
                                    titleController.text,
                                    descController.text,
                                    selectedValue.toString());
                                Navigator.pop(context);
                              });
                            },
                            title: "Add")),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          title: "Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
