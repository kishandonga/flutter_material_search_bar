import 'package:example/msb_dialog_sample.dart';
import 'package:example/msb_sample.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Search AppBar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaterialSearchBarDialogSample(),
                  ),
                );
              },
              child: const Text('MSB With Dialog'),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
