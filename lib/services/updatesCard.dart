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
          elevation:8,
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
