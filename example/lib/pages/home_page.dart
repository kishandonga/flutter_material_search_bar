import 'package:example/pages/msb_sample.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Search Bar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MaterialSearchBarSample(),
              ),
            );
          },
          child: const Text('MSB with AppBar'),
        ),
      ),
    );
  }
}
