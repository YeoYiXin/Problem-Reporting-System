import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../functions/getName.dart';
import '../functions/getPoints.dart';
import '../functions/getProfilePic.dart';

class ProfileButton extends StatefulWidget {
  final currentUser;
  const ProfileButton({super.key,required this.currentUser});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
      child: ElevatedButton(
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Set background color to white
          // foregroundColor: Colors.black, // Set text color to black
          // elevation: 10, // Add elevation to create a pop-out effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded edges
            // side: BorderSide(color: Colors.grey.shade200), // Border color
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: GetProfilePic(uid: widget.currentUser.uid),
                ),
                const SizedBox(
                    width: 8.0), // Adjust the spacing between icon and label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetName(uid: widget.currentUser.uid, section: "MainName"),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow,
                              size: 20), // Add the icon here
                          const Gap(10),
                          const Text(
                            'Points:',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black),
                          ),
                          const Gap(5),
                          GetPoints(uid: widget.currentUser.uid),
                          const SizedBox(width: 8.0),
                          // Add the icon here
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.more_vert), // Three dots icon
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
