import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const MainButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // : BorderRadius.circular(30.0),
            backgroundColor: Colors.grey[700],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            onPress();
          }),
    );
  }
}
