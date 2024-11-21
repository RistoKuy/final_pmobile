import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
      debugShowCheckedModeBanner: false, // Remove "Demo" watermark
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';
  String strAngka2 = '';
  int hasil = 0;
  int angka1 = 0;
  int angka2 = 0;
  int operasi = 0;

  void _tampil(int angka) {
    setState(() {
      if (operasi == 0) {
        display = display == '0' ? '$angka' : display + '$angka';
      } else {
        strAngka2 = strAngka2 == '' ? '$angka' : strAngka2 + '$angka';
        display = display + '$angka';
      }
    });
  }

  void _tambah() {
    setState(() {
      operasi = 1;
      angka1 = int.parse(display);
      display += '+';
    });
  }

  void _kurang() {
    setState(() {
      operasi = 2;
      angka1 = int.parse(display);
      display += '-';
    });
  }

  void _kali() {
    setState(() {
      operasi = 3;
      angka1 = int.parse(display);
      display += '*';
    });
  }

  void _bagi() {
    setState(() {
      operasi = 4;
      angka1 = int.parse(display);
      display += '/';
    });
  }

  void _jumlah() {
    setState(() {
      angka2 = int.parse(strAngka2);
      if (operasi == 1) {
        hasil = angka1 + angka2;
      } else if (operasi == 2) {
        hasil = angka1 - angka2;
      } else if (operasi == 3) {
        hasil = angka1 * angka2;
      } else if (operasi == 4) {
        hasil = angka1 ~/ angka2;
      }
      display = '$hasil';
      strAngka2 = '';
      operasi = 0;
    });
  }

  void _reset() {
    setState(() {
      display = '0';
      strAngka2 = '';
      hasil = 0;
      angka1 = 0;
      angka2 = 0;
      operasi = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            display,
            style: TextStyle(fontSize: 48),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('1', () => _tampil(1)),
              _buildButton('2', () => _tampil(2)),
              _buildButton('3', () => _tampil(3)),
              _buildButton('+', _tambah),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('4', () => _tampil(4)),
              _buildButton('5', () => _tampil(5)),
              _buildButton('6', () => _tampil(6)),
              _buildButton('-', _kurang),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('7', () => _tampil(7)),
              _buildButton('8', () => _tampil(8)),
              _buildButton('9', () => _tampil(9)),
              _buildButton('*', _kali),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('0', () => _tampil(0)),
              _buildButton('CLR', _reset),
              _buildButton('=', _jumlah),
              _buildButton('/', _bagi),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}