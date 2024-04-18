import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class ProfileButton extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;
  const ProfileButton({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _userStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream to listen for updates to the user document
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .snapshots();
  }

  String extractUsername(String email) {
    return email.split('@')[0];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final userData = snapshot.data?.data();
        final points = userData?['points'] ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                //   child: CircleAvatar(
                //     radius: 20,
                //     backgroundImage: NetworkImage(
                //       userData?['profilePicURL'] ?? '',
                //     ),
                //   ),
                // ),
                userData?['profilePicURL'] != null
                    ? Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(userData?['profilePicURL'] ?? ''),
                                      ),
                    )
                    : Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: CircleAvatar(
                                        radius: 20,
                                        child: Text(
                      extractUsername(userData?['email'] ?? '')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                        ),
                                      ),
                    ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        extractUsername(userData?['email'] ?? ''),
                        style: const TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 20),
                          const Gap(10),
                          const Text(
                            'Points:',
                            style: TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          const Gap(5),
                          Text(
                            points.toString(),
                            style: const TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
