import 'package:flutter/material.dart';
import 'package:store/views/home_view.dart';

void main() {
  runApp(const Store());
}


class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen()
    );
  }
}