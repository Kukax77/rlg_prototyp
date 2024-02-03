import 'package:flutter/material.dart';

class CustomButtonSI extends StatelessWidget {
  final String inhalt;
  final Function onTab;
  const CustomButtonSI({super.key, required this.inhalt, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return InkResponse(
      onTap:()=> onTab(),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: themData.colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          inhalt,
          style: themData.textTheme.bodyLarge!.copyWith(
              fontSize: 16, color: Colors.blueGrey[800], letterSpacing: 4),
        )),
      ),
    );
  }
}
