import 'dart:math';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter/material.dart';

class ScreenAlarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScreenAlarm();
  }
}

class _ScreenAlarm extends State {
  DateTime _wakeTime = DateTime.now();
  DateTime _sleepTime = DateTime.now();
  DateTime _fallingAsleepTime = DateTime.now();
  final timeController = TextEditingController();
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text("When do you want to wake up?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            hourMinute12H(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _wakeTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _wakeTime.minute.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text("When do you go to bed?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
                child: TextField(
              readOnly: true,
              controller: timeController,
              decoration:
                  InputDecoration(hintText: 'Please select your bed time'),
              onTap: () async {
                var time = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                timeController.text = time!.format(context);
                setState(() {
                  _sleepTime = DateTime(_sleepTime.year, _sleepTime.month,
                      _sleepTime.day, time.hour, time.minute);
                });
              },
            )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _sleepTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _sleepTime.minute.toString().padLeft(2, '0') +
                    ':' +
                    _sleepTime.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text("How long does it take you to fall asleep?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: Slider(
                value: _currentSliderValue,
                max: 60,
                divisions: 6,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    _fallingAsleepTime = DateTime(
                        _fallingAsleepTime.year,
                        _fallingAsleepTime.month,
                        _fallingAsleepTime.day,
                        0,
                        _currentSliderValue.toInt());
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _fallingAsleepTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _fallingAsleepTime.minute.toString().padLeft(2, '0') +
                    ':' +
                    _fallingAsleepTime.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/stateless"),
        tooltip: 'Stateless',
        child: const Icon(Icons.arrow_circle_right),
      ),*/
    );
  }

  Widget hourMinute12H() {
    return new TimePickerSpinner(
      spacing: 30,
      isForce2Digits: true,
      time: DateTime.now(),
      itemHeight: 50,
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _wakeTime = time;
        });
      },
    );
  }
}
