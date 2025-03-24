import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final TextEditingController textEditingController;

  const TextBox(
      {super.key,
      this.maxLine = 1,
      required this.textEditingController,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLines: maxLine,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
