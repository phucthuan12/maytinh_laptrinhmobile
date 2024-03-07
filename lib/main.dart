import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _input = '';
  String _output = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '';
      } else if (buttonText == '=') {
        _calculateResult();
      } else {
        _input += buttonText;
      }
    });
  }
  void _calculateResult() {
    try {
      // Thực hiện phép tính
      double result = Function.apply(
        _evaluateExpression,
        [_input],
      );

      // Hiển thị kết quả
      _output = result.toString();
    } catch (e) {
      _output = 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    // Xử lý phép tính cơ bản
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    return double.parse(expression);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      _onButtonPressed(buttons[index]);
                    },
                    child: Text(
                      buttons[index],
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> buttons = [
    '7',
    '8',
    '9',
    '÷',
    '4',
    '5',
    '6',
    '×',
    '1',
    '2',
    '3',
    '-',
    '0',
    'C',
    '=',
    '+',
  ];

  @override
  void initState() {
    super.initState();
  }
}
