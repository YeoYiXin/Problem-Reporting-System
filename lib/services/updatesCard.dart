import 'package:flutter/material.dart';
import 'update.dart';

class UpdateCard extends StatelessWidget {
  final Update update;
  UpdateCard({ required this.update });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        child: Card(
          color: Colors.blue[50],
          elevation: 15.0, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                16.0), // Adjust the border radius as needed
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:<Widget>[
                Text(
                  update.issue,
                  style: TextStyle(
                    fontSize:18.0,
                    color:Colors.black,
                  ),
                ),
                SizedBox(height:8.0,),
                Text(
                  update.username,
                  style: TextStyle(
                    fontSize:18.0,
                    color:Colors.black,
                  ),
                ),
                SizedBox(height:8.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
