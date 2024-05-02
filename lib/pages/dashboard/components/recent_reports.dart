// Written by Grp B
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/recent_reports_items.dart';

class RecentProblemsSection extends StatelessWidget {

  const RecentProblemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final problemsStream = FirebaseFirestore.instance.collection('problemsRecord').orderBy('date', descending: true).limit(5).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: problemsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        return Expanded(
          child: ListView.builder(
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
          ),
        );
      },
    );
  }
}
