import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:problem_reporting_system/services/update.dart';
import 'package:problem_reporting_system/services/updatesCard.dart';
import 'dart:io';
import 'ErrorIdentificationPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File? imageFile;

  //get updates from database

  //example
  List<Update> updates = [
    Update(issue:'lamp post is now fixed',username:'hcysc2'),
    Update(issue:'air conditioner in F3B08 is now fixed',username:'hcysc2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/nottinghamlogo.jpg',
          height: 200,
          width: 200,
          color: Colors.white,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                'My profile',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ), //profile
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: CircleAvatar(radius: 40.0),
                ), //avatar
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: Text(
                    'Username: \n\nLevel: \n\nPoints:',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ), //profile stats
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Center(
                child: Text(
                  'Updates on issues and fixes',
                  style: TextStyle(
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ), //updates for fixtures and reports
            //this part
            Expanded(
              child: Column(
                children: updates.map((update) => UpdateCard(update: update)).toList(),
              ), //the reports and update cards
            ), //so that the 3 icons stay at the bottom of the page
            Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    height: 1.0,
                    thickness: 2.0,
                    color: Colors.black,
                  ),
                ),
                  Container(
                    child: OutlinedButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      child: Icon(
                        Icons.camera_alt,
                        size: 50.0,
                        color: Colors.black,
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(18),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Divider(
                    height: 1.0,
                    thickness:2.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Column(
                          children: [
                            Icon(
                              Icons.house,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        label: Text('',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ), //home button
                    Container(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Column(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        label: Text('',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ), //settings button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if(file?.path != null){
      setState((){
        imageFile = File(file!.path);
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorIdentification(imageFile: imageFile), //goes to the next page
        ),
      );
    }
  }
}




