import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateCardItems extends StatefulWidget {

  final String reportPicURL;
  final String title;
  final String status;

  const UpdateCardItems({super.key, required this.reportPicURL, required this.title, required this.status});

  @override
  State<UpdateCardItems> createState() => UpdateCardItemsState();
}

class UpdateCardItemsState extends State<UpdateCardItems> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          child: Card(
            elevation: 15.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomRight,
                //   colors: [
                //     const Color(0xFF0041E8).withOpacity(0.5),
                //     const Color(0xFFBBA7F5).withOpacity(0.7),
                //   ],
                // ),
                color: Colors.white.withOpacity(0.85),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    // Positioned(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width / 4,
                    //     child: ColorFiltered(
                    //       colorFilter: ColorFilter.mode(
                    //         Colors.orangeAccent.withOpacity(0.5), // Adjust the opacity as needed
                    //         BlendMode.srcATop,
                    //       ),
                    //       child: Image.asset('assets/hazard.png'),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      children: [
                        Image.network(widget.reportPicURL,
                          width: 50,
                          fit: BoxFit.cover,),
                        // Expanded(
                        //   flex: 1,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(16.0),
                        //     child: Image.asset(
                        //       'assets/space.png',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: 12.0),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // GetReportTitle(problemId: problemId),
                              Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,),),
                              SizedBox(height: 8.0),
                              // GetReportStatus(problemId: problemId),
                              Text('Status: ' + widget.status),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
