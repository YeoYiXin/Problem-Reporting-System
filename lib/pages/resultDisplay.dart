import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String result;

  ResultDisplay({required this.result});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Classification Result'),
      content: Text(result),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
