import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/widget.dart';

class QuizeView extends StatelessWidget {
  const QuizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Start Quize'),
            ),
          ],
        ),
        body: commentTextField(context));
  }
}
