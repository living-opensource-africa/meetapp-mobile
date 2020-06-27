import 'package:flutter/material.dart';

class BottomNav {
  BottomNav(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

List<BottomNav> options = <BottomNav>[
  BottomNav('Home', Icons.home, Colors.white),
  BottomNav('Meeting', Icons.video_call, Colors.white),
  BottomNav('About', Icons.info, Colors.white)
];