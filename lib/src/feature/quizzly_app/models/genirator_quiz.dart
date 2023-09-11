import 'dart:math';

import 'package:flutter/cupertino.dart';

class GeniratorQuiz {
  Random random = Random();
  late int _a;
  late int _b;
  late ValueNotifier<String> consoleText;
  late ValueNotifier<int> operator;
  late ValueNotifier<List<double>> answersList;

  GeniratorQuiz() {
    _a = random.nextInt(50);
    _b = random.nextInt(50) + 1;
    operator = ValueNotifier(random.nextInt(4));
    consoleText = ValueNotifier("$_a ${getOperator()} $_b = ?");
    answersList = ValueNotifier(getList());
  }

  List<double> getList() {
    List<double> result = createList();
    while (result.length != result.toSet().length) {
      result = createList();
    }

    return result..shuffle();
  }

  List<double> createList() {
    return [
      correctAnswer(),
      ...List.generate(
        3,
        (index) => random.nextInt(50).toDouble(),
      ),
    ];
  }

  double correctAnswer() {
    return switch (getOperator()) {
      "+" => (_a + _b).toDouble(),
      "-" => (_a - _b).toDouble(),
      "*" => (_a * _b).toDouble(),
      "/" => (_a / _b).toDouble(),
      _ => 0,
    };
  }

  String getOperator() {
    return ["+", "-", "*", "/"].elementAt(operator.value);
  }

  void reset() {
    _a = random.nextInt(50);
    _b = random.nextInt(50)+1;
    operator.value = random.nextInt(4);
    consoleText.value ="$_a ${getOperator()} $_b = ?";
    answersList.value = getList();
  }
}
