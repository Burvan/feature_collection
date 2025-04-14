import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Character screen',
        ),
      ),
    );
  }
}
