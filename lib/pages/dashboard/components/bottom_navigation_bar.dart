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
      color: Colors.blue.shade200.withOpacity(0.7), // Change color to match your theme
      backgroundColor: Colors.transparent, // Transparent background
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
    // return Container(
    //   height: 70,
    //   margin:
    //   const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    //   // decoration: BoxDecoration(
    //   //   color: Colors.black,
    //   //   borderRadius: const BorderRadius.all(Radius.circular(24)),
    //   //   border: Border.all(color: Colors.black),
    //   // ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(
    //         horizontal: 15.0, vertical: 0),
    //     child: GNav(
    //       selectedIndex: _selectedIndex,
    //       onTabChange: (selectedIndex) {
    //         _navigateToPage(selectedIndex);
    //       },
    //       // backgroundColor: Colors.black,
    //       color: Colors.grey.shade700,
    //       activeColor: Colors.white,
    //       tabBackgroundColor: Colors.grey.shade800,
    //       gap: 8,
    //       padding: const EdgeInsets.symmetric(
    //           horizontal: 16, vertical: 10),
    //       tabs: const [
    //         GButton(
    //           icon: Icons.house_outlined,
    //           text: 'Home',
    //         ),
    //         GButton(
    //           icon: Icons.camera_alt,
    //           text: 'Camera',
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
