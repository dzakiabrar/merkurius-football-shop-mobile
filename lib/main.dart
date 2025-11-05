import 'package:flutter/material.dart';
import 'package:merkurius_football_shop/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merkurius Football Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.blueAccent),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
