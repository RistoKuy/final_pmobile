import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String display = '0';

  void _updateDisplay(String value) {
    setState(() {
      display = display == '0' ? value : display + value;
    });
  }

  void _performOperation(String operator) {
    setState(() {
      if (display.isNotEmpty && !isOperator(display[display.length - 1])) {
        display += operator;
      }
    });
  }

  bool isOperator(String value) {
    return ['+', '-', '*', '/'].contains(value);
  }

  void _calculateResult() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(display);
        ContextModel cm = ContextModel();
        display = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        display = 'Error';
      }
    });
  }

  void _resetDisplay() {
    setState(() {
      display = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(display, style: const TextStyle(fontSize: 48, color: Colors.white)),
          for (var row in [
            ['1', '2', '3', '+'],
            ['4', '5', '6', '-'],
            ['7', '8', '9', '*'],
            ['C', '0', '=', '/']
          ])
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((label) {
                return _buildButton(
                  label,
                  label == 'C'
                      ? _resetDisplay
                      : label == '='
                          ? _calculateResult
                          : isOperator(label)
                              ? () => _performOperation(label)
                              : () => _updateDisplay(label),
                  color: label == 'C' ? Colors.red : label == '=' ? Colors.green : Colors.blue,
                  textColor: Colors.white,
                );
              }).toList(),
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
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}