import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '24HR Clock Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool addIsChecked = false;
  bool subtractIsChecked = false;
  String displayHours = '00';
  String displayMinutes = '00';
  String displaySeconds = '00';
  String display = '00:00:00';

  final TextEditingController _hoursController1 = TextEditingController();
  final TextEditingController _minutesController1 = TextEditingController();
  final TextEditingController _secondsController1 = TextEditingController();
  final TextEditingController _hoursController2 = TextEditingController();
  final TextEditingController _minutesController2 = TextEditingController();
  final TextEditingController _secondsController2 = TextEditingController();

  void _calculateAdd() {
    int hours1 = int.parse(_hoursController1.text);
    int hours2 = int.parse(_hoursController2.text);
    int minutes1 = int.parse(_minutesController1.text);
    int minutes2 = int.parse(_minutesController2.text);
    int seconds1 = int.parse(_secondsController1.text);
    int seconds2 = int.parse(_secondsController1.text);

    setState(() {
      int totalSeconds = seconds1 + seconds2;
      int carryMinutes = totalSeconds ~/ 60;
      int remainingSeconds = totalSeconds % 60;

      int totalMinutes = minutes1 + minutes2 + carryMinutes;
      int carryHours = totalMinutes ~/60;
      int remainingMinutes = totalMinutes % 60;

      int totalHours = hours1 + hours2 + carryHours;
      totalHours %= 24;


      display = '${totalHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    });



  }

  void _calculateSubtract() {
    int hours1 = int.parse(_hoursController1.text);
    int hours2 = int.parse(_hoursController2.text);
    int minutes1 = int.parse(_minutesController1.text);
    int minutes2 = int.parse(_minutesController2.text);
    int seconds1 = int.parse(_secondsController1.text);
    int seconds2 = int.parse(_secondsController1.text);

    setState(() {
      int totalSeconds = seconds1 - seconds2;
      if (totalSeconds < 0) {
        totalSeconds += 60;
        minutes1 -= 1;
      }

      // Subtract minutes
      int totalMinutes = minutes1 - minutes2;
      if (totalMinutes < 0) {
        totalMinutes += 60;
        hours1 -= 1;
      }

      // Subtract hours
      int totalHours = hours1 - hours2;
      if (totalHours < 0) {
        totalHours += 24;
      }

      display = '${totalHours.toString().padLeft(2, '0')}:${totalMinutes.toString().padLeft(2, '0')}:${totalSeconds.toString().padLeft(2, '0')}';
    });
  }

  void reset() {
    _hoursController1.clear();
    _hoursController2.clear();
    _minutesController1.clear();
    _minutesController2.clear();
    _secondsController1.clear();
    _secondsController2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(display,
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ))
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2), // Limit input to 2 characters
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    controller: _hoursController1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Hour',
                    ),
                  )
                  ,
                ),
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2), // Limit input to 2 characters
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    controller: _minutesController1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Minute',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2), // Limit input to 2 characters
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits,
                    ],
                    controller: _secondsController1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Seconds',
                  ),
                ),),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: addIsChecked,
                  onChanged: (value) {
                    setState(() {
                      addIsChecked = value!;
                      subtractIsChecked = false;
                    });
                  },
                ),
                const Text(
                  'Add (+)',
                  style: TextStyle(fontSize: 16.0),
                ),
                Checkbox(
                  value: subtractIsChecked,
                  onChanged: (value) {
                    setState(() {
                      subtractIsChecked = value!;
                      addIsChecked = false;
                    });
                  },
                ),
                const Text(
                  'Subtract (-)',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2), // Limit input to 2 characters
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    controller: _hoursController2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Hour',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _minutesController2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Minute',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    inputFormatters:  [
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _secondsController2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Seconds',
                    ),
                  ),),
              ],
            ),
            ElevatedButton(
              onPressed: addIsChecked
                  ? () {
                _calculateAdd();
              }
                  : () {
                _calculateSubtract();
              },
              child: const Text('Calculate time'),

            ),
            TextButton(
              onPressed: reset,
              child: const Text('Reset calculator'),

            )
          ],
        ),
      ),
    );
  }
}
