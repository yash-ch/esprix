//create a stateful widget
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatrixControl extends StatefulWidget {
  const MatrixControl({Key? key}) : super(key: key);

  @override
  _MatrixControlState createState() => _MatrixControlState();
}

class _MatrixControlState extends State<MatrixControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dot Matrix Controller'),
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          // letterSpacing: 2.0,
          color: Colors.black,
          fontFamily: 'montserrat',
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
