import 'dart:math';
import 'package:flutter/material.dart';

class SceenInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey[900],
        backgroundColor: Colors.grey[900],
        title: const Text('Sleep Calculator',
            style: TextStyle(color: Colors.indigoAccent)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  "Stages of Sleep",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Container(
              child: const Center(
                child: Text(
                  "When thinking about getting the sleep you need, it’s normal to focus on how many hours of sleep you get. While sleep duration is undoubtedly important, it’s not the only part of the equation. It’s also critical to think about sleep quality and whether the time spent sleeping is actually restorative. Progressing smoothly multiple times through the sleep cycle, composed of four separate sleep stages, is a vital part of getting truly high-quality rest.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Container(
              child: Image.asset("screenshots/ss2.jpg"),
            ),
            Container(
              child: Center(
                child: Text(
                  "Each sleep stage plays a part in allowing your mind and body to wake up refreshed. Understanding the sleep cycle also helps explain how certain sleep disorders, including insomnia and obstructive sleep apnea can impact a person’s sleep and health.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "What Is the Sleep Cycle?",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "Sleep is not uniform. Instead, over the course of the night, your total sleep is made up of several rounds of the sleep cycle, which is composed of four individual stages. In a typical night, a person goes through four to six sleep cycles. Not all sleep cycles are the same length, but on average they last about 90 minutes each.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Container(
              child: Image.asset(
                "screenshots/ss1.jpg",
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  "Referance: www.sleepfoundation.org/stages-of-sleep",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.black87,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.indigoAccent,
              ),
              onPressed: () => Navigator.pushNamed(context, "/info"),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.amberAccent[200],
              ),
              onPressed: () {
                //FlutterAlarmClock.showAlarms();
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        highlightElevation: 40,
        elevation: 10,
        splashColor: Colors.amberAccent[200],
        hoverColor: Colors.amberAccent[200],
        backgroundColor: Colors.indigoAccent[700],
        foregroundColor: Colors.amberAccent[200],
        focusColor: Colors.amberAccent[200],
        onPressed: () => Navigator.pushNamed(context, "/alarm"),
        child: Icon(
          Icons.alarm,
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}
