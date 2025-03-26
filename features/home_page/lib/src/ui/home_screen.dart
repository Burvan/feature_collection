import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home screen'),
      ),
    );
  }
}
