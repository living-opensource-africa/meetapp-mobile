import 'package:flutter/material.dart';
import 'package:meetapp/widgets/main_content.dart';
import 'package:meetapp/values/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentTextTheme: Typography.whiteMountainView),
      home: MyHomePage(title: app_name),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MainContent(Colors.white, 'home'),
    MainContent(Colors.orange, 'meeting'),
    MainContent(Colors.green, 'about')
  ];

  void tabView(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: tabView,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text('Meeting'),
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About'),
            backgroundColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
