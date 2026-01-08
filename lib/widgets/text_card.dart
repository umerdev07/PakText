import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String text;

  const TextCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
