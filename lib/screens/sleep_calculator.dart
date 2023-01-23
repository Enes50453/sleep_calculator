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
      backgroundColor: Colors.grey[900],
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
            SizedBox(height: 30),
            Divider(
              height: 2.0,
              color: Colors.amberAccent[200],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
            Container(
              child: Text("When do you want to wake up?",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent[100])),
            ),
            hourMinute12H(),
            SizedBox(height: 10),
            Divider(
              height: 2.0,
              color: Colors.amberAccent[200],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 10),
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _wakeTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _wakeTime.minute.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),*/
            Container(
              child: Text("When do you go to bed?",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent[100])),
            ),
            Container(
                child: TextField(
              style: TextStyle(color: Colors.indigoAccent),
              readOnly: true,
              controller: timeController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                icon: Icon(
                  Icons.access_time,
                  color: Colors.indigoAccent,
                ),
                hintText: 'Please select your bed time',
                hintStyle: TextStyle(
                  color: Colors.indigoAccent[100],
                ),
              ),
              onTap: () async {
                var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.amberAccent, // <-- SEE HERE
                            onPrimary: Colors.deepPurpleAccent, // <-- SEE HERE
                            onSurface: Colors.indigoAccent, // <-- SEE HERE
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.indigoAccent, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (time == null) return;
                timeController.text = time.format(context);
                setState(() {
                  calculate();
                  _sleepTime = DateTime(_sleepTime.year, _sleepTime.month,
                      _sleepTime.day, time.hour, time.minute);
                  //_difference = _wakeTime.difference(_sleepTime);
                });
              },
            )),
            SizedBox(height: 20),
            Divider(
              height: 2.0,
              color: Colors.amberAccent[200],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 20),
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _sleepTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _sleepTime.minute.toString().padLeft(2, '0') +
                    ':' +
                    _sleepTime.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),*/
            Container(
              child: Text("How long does it take you to fall asleep?",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent[100])),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Slider(
                activeColor: Colors.indigoAccent,
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
            Divider(
              height: 2.0,
              color: Colors.amberAccent[200],
              thickness: 1.5,
              indent: 0,
              endIndent: 0,
            ),
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _fallingAsleepTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _fallingAsleepTime.minute.toString().padLeft(2, '0') +
                    ':' +
                    _fallingAsleepTime.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),*/
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(totalMinute.toString()),
            ),*/
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                  "sleep cycles = $calculatedCycle + $calculatedHours + $calculatedMinutes"),
            ),*/
            /*Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: new Text(
                _withFAT.hour.toString().padLeft(2, '0') +
                    ':' +
                    _withFAT.minute.toString().padLeft(2, '0') +
                    ':' +
                    _withFAT.second.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[900],
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
                FlutterAlarmClock.showAlarms();
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        highlightElevation: 50,
        elevation: 15,
        splashColor: Colors.amberAccent[200],
        hoverColor: Colors.amberAccent[200],
        backgroundColor: Colors.indigoAccent[700],
        foregroundColor: Colors.amberAccent[200],
        focusColor: Colors.amberAccent[200],
        onPressed: () {
          setAlarm();
        },
        icon: Icon(
          Icons.alarm,
          color: Colors.amberAccent,
        ),
        label: Text("Set Alarm"),
      ),
    );
  }

  calculate() {
    _withFAT = DateTime(_withFAT.year, _withFAT.month, _withFAT.day,
        _sleepTime.hour, _sleepTime.minute + _fallingAsleepTime.minute);
    _difference = _wakeTime.difference(_withFAT);
    totalMinute = _difference.inMinutes >= 0
        ? _difference.inMinutes.toInt()
        : _difference.inMinutes.toInt() * (-1) + 24 * 60;
    calculatedCycle = (totalMinute / remCycle).floor();
    calculatedHours = ((calculatedCycle * remCycle) / 60).floor();
    calculatedMinutes = (calculatedCycle * remCycle) % 60;
    _calculatedAlarm = DateTime(_withFAT.year, _withFAT.month, _withFAT.day,
        _withFAT.hour + calculatedHours, _withFAT.minute + calculatedMinutes);
  }

  setAlarm() {
    calculate();
    return FlutterAlarmClock.createAlarm(
        _calculatedAlarm.hour, _calculatedAlarm.minute);
  }

  Widget hourMinute12H() {
    return new TimePickerSpinner(
      normalTextStyle: TextStyle(
        color: Colors.indigoAccent,
        fontSize: 20,
      ),
      highlightedTextStyle: TextStyle(
        color: Colors.indigoAccent,
        fontSize: 35,
      ),
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
