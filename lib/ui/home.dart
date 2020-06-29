import 'package:flutter/material.dart';
import 'package:meetapp/values/strings.dart';

class HomeTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Image.asset(landingPageImage),
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[],)
      ]
    );
  }
}