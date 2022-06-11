import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// stless 입력후 tap키
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('안녕')
    );
  }
}

