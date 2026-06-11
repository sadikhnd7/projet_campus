import 'package:flutter/material.dart';

void main() => runApp(const BourseApp());

class BourseApp extends StatelessWidget {
  const BourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Projet Campu')),
      ),
    );
  }
}