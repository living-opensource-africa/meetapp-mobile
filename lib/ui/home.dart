import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      transform: Matrix4.rotationZ(0.2),
      child: Text(
        'Welcome Home',
        style: TextStyle(
          color: Colors.white,
          fontSize: 45,
          fontWeight: FontWeight.w400)
      )
    );
  }
}