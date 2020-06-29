import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(17),
                //color: Color.fromARGB(0, 255, 255, 255),
                child: Text('Living Open Source Foundation',
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent))),
            Card(
              margin: EdgeInsets.all(15),
              color: Colors.white,
              child: RichText(
                  text: TextSpan(
                      text: ' ',
                      style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(text: 'The mission of the '),
                    TextSpan(text: 'Living Open Source Foundation '),
                    TextSpan(
                        text:
                            'is to foster the adoption and use of Open Source solutions '),
                    TextSpan(
                        text:
                            'as a way of building sustainable, and technologically advanced economies across Africa.')
                  ])),
            )
          ],
        ));
  }
}
