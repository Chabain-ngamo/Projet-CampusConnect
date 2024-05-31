import 'package:flutter/material.dart';

class ButtonBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left_outlined,
          color: Colors.black,
          size: 45,
        ),
      ),
    );
  }
}
