import 'dart:math';
import 'package:flutter/material.dart';

class SceenInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("Stateless Widget"),
      ),*/
      body: Column(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/alarm"),
        tooltip: 'Stateful',
        child: const Icon(Icons.arrow_circle_left),
      ),
    );
  }
}
