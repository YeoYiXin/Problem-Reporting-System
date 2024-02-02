import 'package:flutter/material.dart';
import 'report.dart';

class ReportCardItem extends StatelessWidget {
  final Report report;
  ReportCardItem({required this.report});

  @override
  Widget build(BuildContext context) {
    double cardSize = 175.0;

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
              Text(
                report.issue,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjusted text color
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                report.date,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                report.progress,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

