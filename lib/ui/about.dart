import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            child: Column(
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(17),
                //color: Color.fromARGB(0, 255, 255, 255),
                child: Text('Living Open Source Foundation',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent))),
            Container(
                margin: EdgeInsets.all(25),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Text(
                        'The mission of the Living Open Source Foundation is to foster the adoption and use of Open Source Software. We are doing this so as to build sustainable ICT solutions for Africa.'),
                    Text(
                        'In Zambia, the community (Living Open Source) has partnered with INFRATEL (formerly Zambia National Data Centre) to provide a secure video conferencing platform without a fee.'),
                    Text(
                        'This is in an effort to bridge the distance without breaking the rules of social distancing brought about by the COVID-19 pandemic.'),
                    Text(
                        'Through the collaborative efforts of INFRATEL and the Living Open Source Community, we are making education, meetings, trainings and social events a possibilty whilst still observing social distancing'),
                    Text(
                        'Beyond the pandemic, the community is looking into training and certifying professionals in different areas of Open Source.'),
                    Text(
                        'As the Living Open Source Community, we are open to individuals and organisations advocating for digital freedom.'),
                    SizedBox(height: 60),
                    Text(
                        'Please reach out to the community by emailing info@livingopensource.africa')
                  ]),
                ))
          ],
        )));
  }
}
