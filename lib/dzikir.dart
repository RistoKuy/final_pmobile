// ignore: file_names
import 'package:flutter/material.dart';

class DzikirScreen extends StatefulWidget {
  const DzikirScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DzikirScreenState createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dzikir Counter'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Jumlah Dzikir:',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Tambah'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _resetCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
