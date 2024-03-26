import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:problem_reporting_system/pages/dashboard/services/Camera.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => MyBottomNavigationBarState();
}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final int _selectedIndex = 0;
  Camera camera = Camera();

  @override
  void initState() {
    super.initState();
    // Set the callback to trigger a rebuild when an image is selected
    camera.onImageSelected = () {
      setState(() {});
    };
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
      //refresh logic
        break;
      case 1:
      // Camera button tapped
        camera.onTapCameraButton(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.blue.shade200, // Change color to match your theme
      backgroundColor: Colors.blueGrey, // Transparent background
      items: [
        CurvedNavigationBarItem(
          child: Icon(Icons.home),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.camera_alt),
          label: 'Camera',
        ),
      ],
      onTap: (index) {
        _navigateToPage(index);
      },
    );
  }
}
