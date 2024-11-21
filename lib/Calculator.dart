// ignore: file_names
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'main.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          onPrimary: Colors.black,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
      ),
      home: const Calculator(),
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
  String expression = '';

  void _tampil(String value) {
    setState(() {
      if (display == '0') {
        display = value;
      } else {
        display += value;
      }
    });
  }

  void _operasi(String operator) {
    setState(() {
      if (display.isNotEmpty && !isOperator(display[display.length - 1])) {
        display += operator;
      }
    });
  }

  bool isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }

  void _jumlah() {
    setState(() {
      try {
        expression = display;
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        display = eval.toString();
      } catch (e) {
        display = 'Error';
      }
    });
  }

  void _reset() {
    setState(() {
      display = '0';
      expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Back Button to Main Menu
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu()));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            display,
            style: const TextStyle(fontSize: 48, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('1', () => _tampil('1')),
              _buildButton('2', () => _tampil('2')),
              _buildButton('3', () => _tampil('3')),
              _buildButton('+', () => _operasi('+'), color: Colors.black, textColor: Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('4', () => _tampil('4')),
              _buildButton('5', () => _tampil('5')),
              _buildButton('6', () => _tampil('6')),
              _buildButton('-', () => _operasi('-'), color: Colors.black, textColor: Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('7', () => _tampil('7')),
              _buildButton('8', () => _tampil('8')),
              _buildButton('9', () => _tampil('9')),
              _buildButton('*', () => _operasi('*'), color: Colors.black, textColor: Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('C', _reset, color: Colors.red, textColor: Colors.white),
              _buildButton('0', () => _tampil('0')),
              _buildButton('=', _jumlah, color: Colors.green, textColor: Colors.white),
              _buildButton('/', () => _operasi('/'), color: Colors.black, textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed, {Color color = Colors.blue, Color textColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}