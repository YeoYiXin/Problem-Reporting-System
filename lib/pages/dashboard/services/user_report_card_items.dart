// Written by Grp B
import 'package:flutter/material.dart';

class UserReportCardItem extends StatefulWidget {
  final String title;
  final String date;
  final String status;

  const UserReportCardItem({super.key, required this.title, required this.date, required this.status});

  @override
  State<UserReportCardItem> createState() => UserReportCardItemState();
}

class UserReportCardItemState extends State<UserReportCardItem> {

  @override
  Widget build(BuildContext context) {
    double cardSize = 150.0;

    return Card(
      elevation: 15.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.transparent,
      child: Container(
        width: cardSize,
        height: cardSize,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold),),
              Text('Status: ${widget.status}'),
              Text('Date: ${widget.date}'),
            ],
          ),
        ),
      ),
    );
  }
}
