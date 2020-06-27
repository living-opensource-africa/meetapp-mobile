import 'package:flutter/material.dart';
import 'package:meetapp/ui/home.dart';
import 'package:meetapp/ui/about.dart';
import 'package:meetapp/ui/meeting.dart';

class MainContent extends StatefulWidget {
  MainContent(this.color, this.tab);
  final Color color;
  final String tab;
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<MainContent> {  
  @override
  Widget build(BuildContext context) {
    Widget selectedTab;
    if (widget.tab == 'home') {
      selectedTab = HomeTab();
    }
    else if (widget.tab == 'meeting') {
      selectedTab = MeetingTab();
    }
    else if(widget.tab == 'about') {
      selectedTab = AboutTab();
    }
    else {
      selectedTab = HomeTab();
    }
    return Container(
      child: selectedTab,
      color: Colors.orange,
    );

  }
}
