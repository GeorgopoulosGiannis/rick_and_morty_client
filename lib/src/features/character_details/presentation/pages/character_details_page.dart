import 'package:flutter/material.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('detail'),
        ),
      ),
    );
  }
}
