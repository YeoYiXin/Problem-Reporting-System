import 'package:flutter/material.dart';
import 'report.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  ReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 200.0,
        child: Row(
          children: [
            ReportCardItem(report: report),
            SizedBox(width: 8.0),  // Adjust the spacing between cards
          ],
        ),
      ),
    );
  }
}


class ReportCardItem extends StatelessWidget {
  final Report report;
  ReportCardItem({required this.report});

  @override
  Widget build(BuildContext context) {
    // Set a smaller width and height for each card
    double cardSize = 175.0;

    return Card(
      elevation: 15.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.transparent, // Make the card transparent
      child: Container(
        width: cardSize,
        height: cardSize, // Set the height to the same value as width
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffffffff),
              Color(0xff967ae3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                report.issue,
                style: TextStyle(
                  fontSize: 16.0, // Adjust font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                report.date,
                style: TextStyle(
                  fontSize: 12.0, // Adjust font size
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                report.progress,
                style: TextStyle(
                  fontSize: 12.0, // Adjust font size
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
