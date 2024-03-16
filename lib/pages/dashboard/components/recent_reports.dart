import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/recent_reports_items.dart';

class RecentProblemsSection extends StatelessWidget {

  const RecentProblemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final problemsRecord = FirebaseFirestore.instance.collection('problemsRecord');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: const Text(
              'Recent Problems',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: problemsRecord.orderBy('date', descending: true).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No data available'));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];
                  return UpdateCardItems(
                    reportPicURL: doc['problemImageURL'],
                    title: doc['problemTitle'],
                    status: doc['problemStatus'],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
