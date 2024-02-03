import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Material(
        color: Colors.transparent,
        elevation: 16,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height * 0.23,
          width: width *0.7,
          decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Row(children: [Container(width: width*0.4, height: height*0.04,color: Colors.blueGrey,child: Text("20")),const Spacer() ,Text("Title")],),
            Text(""),
        
          ]),
        ));
  }
}
