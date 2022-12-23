import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/mybutton.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final darkColor = const Color(0xFF22252d);
  final lightColor = const Color(0xFFffffff);
  final buttonBackground = const Color(0xFF292d36);
  final darkbutton = const Color(0xFF272b33);
  final specialButtonText = const Color(0xFF26dcbc);
  final operatorButtonText = const Color(0xFFda6162);

  String result = 'result';
  String userQuestion = 'userQuestion';

  List<String> _buttonTexts = [
    'AC',
    'DEL',
    '^',
    '%',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  void evaluate() {
    final finalQuestion = userQuestion.replaceAll('x', '*');
    try {
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      //eval = eval.roundToDouble();
      result = eval.toString();
    } catch (e) {
      userQuestion = 'Format Exception';
      result = '';
    }
  }

  bool isOperator(String text) {
    if (text == '%' ||
        text == '/' ||
        text == 'x' ||
        text == '-' ||
        text == '+' ||
        text == '=' ||
        text == '^')
      return true;
    else
      return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Simple Mode'),
        //   backgroundColor: darkColor,
        // ),
        // drawer: Drawer(),
        backgroundColor: darkColor,
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textAlign: TextAlign.end,
                      userQuestion,
                      style: TextStyle(fontSize: 36, color: lightColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      textAlign: TextAlign.end,
                      result,
                      style: TextStyle(fontSize: 46, color: lightColor),
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: buttonBackground,
                    child: GridView.builder(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        itemCount: _buttonTexts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 4),
                        itemBuilder: ((context, index) {
                          if (index == 0) {
                            return Mybutton(
                                text: _buttonTexts[index],
                                buttonColor: darkbutton,
                                textColor: specialButtonText,
                                works: () {
                                  setState(() {
                                    result = '';
                                    userQuestion = '';
                                  });
                                });
                          } else if (index == 1) {
                            return Mybutton(
                                text: _buttonTexts[index],
                                buttonColor: darkbutton,
                                textColor: specialButtonText,
                                works: () {
                                  setState(() {
                                    userQuestion = userQuestion.length > 1
                                        ? userQuestion.substring(
                                            0, userQuestion.length - 1)
                                        : '';
                                  });
                                });
                          } else if (index == 18) {
                            return Mybutton(
                                text: _buttonTexts[index],
                                buttonColor: darkbutton,
                                textColor: operatorButtonText,
                                works: () {
                                  setState(() {
                                    evaluate();
                                  });
                                });
                          } else {
                            return Mybutton(
                                text: _buttonTexts[index],
                                buttonColor: darkbutton,
                                textColor: isOperator(_buttonTexts[index])
                                    ? operatorButtonText
                                    : lightColor,
                                works: () {
                                  setState(() {
                                    userQuestion += _buttonTexts[index];
                                  });
                                });
                          }
                        })),
                  ),
                )),
          ],
        ));
  }
}
