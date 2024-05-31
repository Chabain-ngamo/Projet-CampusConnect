import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _isLiked ? campuscolor : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(3.0),
        child: Icon(
          Icons.favorite,
          color: _isLiked ? campuscolor : Colors.grey,
          size: 20.0,
        ),
      ),
    );
  }
}
