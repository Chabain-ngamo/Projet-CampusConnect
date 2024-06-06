import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonBackWidget extends StatefulWidget {
  @override
  State<ButtonBackWidget> createState() => _ButtonBackWidgetState();
}

class _ButtonBackWidgetState extends State<ButtonBackWidget> {
  
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Positioned(
      top: 25,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_left_outlined,
          color: color,
          size: 45,
        ),
      ),
    );
  }
}
