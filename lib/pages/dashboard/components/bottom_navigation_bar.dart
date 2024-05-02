import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/dashboard/services/Camera.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => MyBottomNavigationBarState();
}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  Camera camera = Camera();

  @override
  void initState() {
    super.initState();
    camera.onImageSelected = () {
      setState(() {});
    };
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        camera.onTapCameraButton(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.blue.shade200, //change color to match your theme
      backgroundColor: Colors.blueGrey, //transparent background
      items: const [
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
