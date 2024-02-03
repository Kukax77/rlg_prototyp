import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {

  final Function onTab;
  const CustomAddButton({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap:()=> onTab(),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Opacity(
          opacity: 0.7,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                color:Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Icon(Icons.add, color: Colors.white,)),
          ),
        ),
      ),
    );
  }
}
