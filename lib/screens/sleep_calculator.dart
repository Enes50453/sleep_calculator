import 'dart:math';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

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
  DateTime _withFAT = DateTime.now(); //sleeptime with fall asleep time
  DateTime _calculatedAlarm = DateTime.now();
  late Duration _difference = _wakeTime.difference(_withFAT);
  final timeController = TextEditingController();
  double _currentSliderValue = 20;
  int totalMinute = 0;
  int remCycle = 90;
  int calculatedCycle = 10;
  int calculatedHours = 10;
  int calculatedMinutes = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => Navigator.pushNamed(context, "/info"),
        ),
        title: const Text('Sleep Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              FlutterAlarmClock.showAlarms();
            },
          )
        ],
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
                  calculate();
                  _sleepTime = DateTime(_sleepTime.year, _sleepTime.month,
                      _sleepTime.day, time.hour, time.minute);
                  //_difference = _wakeTime.difference(_sleepTime);
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
                max: 50,
                divisions: 5,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    calculate();
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(_difference.inMinutes.toString()),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                  "sleep cycles = $calculatedCycle + $calculatedHours + $calculatedMinutes"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _withFAT.hour.toString().padLeft(2, '0') +
                    ':' +
                    _withFAT.minute.toString().padLeft(2, '0') +
                    ':' +
                    _withFAT.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setAlarm();
        },
        tooltip: 'Stateless',
        child: const Icon(Icons.arrow_circle_right),
      ),
    );
  }

  calculate() {
    _withFAT = DateTime(_withFAT.year, _withFAT.month, _withFAT.day,
        _sleepTime.hour, _sleepTime.minute + _fallingAsleepTime.minute);
    _difference = _wakeTime.difference(_withFAT);
    totalMinute = _difference.inMinutes.toInt();
    calculatedCycle = (totalMinute / remCycle).floor();
    calculatedHours = ((calculatedCycle * remCycle) / 60).floor();
    calculatedMinutes = (calculatedCycle * remCycle) % 60;
    _calculatedAlarm = DateTime(_wakeTime.year, _wakeTime.month, _wakeTime.day,
        calculatedHours, calculatedMinutes);
  }

  setAlarm() {
    calculate();
    return FlutterAlarmClock.createAlarm(
        _calculatedAlarm.hour, _calculatedAlarm.minute);
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
          //_difference = _wakeTime.difference(_sleepTime);
        });
      },
    );
  }
}
