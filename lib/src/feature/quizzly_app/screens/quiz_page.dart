import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzly/src/feature/quizzly_app/widgets/option_button.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../models/genirator_quiz.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  final int? seconds;

  const QuizPage({
    required this.seconds,
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  GeniratorQuiz geniratorQuiz = GeniratorQuiz();
  ValueNotifier<int> count = ValueNotifier(1);
  int correct = 0;
  Timer? timer;
  late ValueNotifier<int> changeSeconds;

  @override
  void initState() {
    super.initState();
    if (widget.seconds != null) {
      changeSeconds = ValueNotifier(widget.seconds!);
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (changeSeconds.value > 0) {
            changeSeconds.value--;
          } else {
            if (count.value == 10) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScorePage(
                    correct: correct,
                    seconds: widget.seconds,
                  ),
                ),
              );
            } else {
              count.value++;
              geniratorQuiz.reset();
              changeSeconds.value = widget.seconds!;
            }
          }
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.mainColor,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(AppIcons.icBack),
        ),
      ),
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.25,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image(
                          color: Colors.white,
                          image: AssetImage(AppIcons.ellipse1),
                          width: 98,
                          height: 98,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          image: AssetImage(AppIcons.ellipse2),
                          width: 98,
                          height: 98,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage(AppIcons.ellipse3),
                          width: 98,
                          height: 98,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(AppIcons.ellipse4),
                          width: 98,
                          height: 98,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 40, right: 40),
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.8,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blur,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: count,
                                builder: (context, value, child) {
                                  return Text(
                                    "Question $value/10",
                                    style: const TextStyle(
                                      color: AppColor.mainTextColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: geniratorQuiz.consoleText,
                                builder: (context, value, child) {
                                  return Text(
                                    value,
                                    style: const TextStyle(
                                      color: AppColor.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Align(
                      child: SizedBox(
                        width: size.width * 0.17,
                        height: size.height * 0.17,
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                          child: widget.seconds == null
                              ? const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.mainTextColor,
                                    ),
                                    Center(
                                      child: Text(
                                        "∞",
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ValueListenableBuilder(
                                  valueListenable: changeSeconds,
                                  builder: (context, value, child) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox.square(
                                          dimension: 50,
                                          child: CircularProgressIndicator(
                                            value: value / widget.seconds!,
                                            color: AppColor.mainTextColor,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "$value",
                                            style: const TextStyle(
                                              color: AppColor.mainTextColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          ValueListenableBuilder(
            valueListenable: geniratorQuiz.answersList,
            builder: (context, value, child) {
              return Column(
                children: List.generate(
                  value.length,
                  (index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.005),
                      child: OptionButton(
                        text: value[index].toStringAsFixed(1),
                        onPressed: () {
                          if (value[index] == geniratorQuiz.correctAnswer()) {
                            correct++;
                          }
                          if (count.value == 10) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScorePage(
                                  correct: correct,
                                  seconds: widget.seconds,
                                ),
                              ),
                            );
                          } else {
                            count.value++;
                            geniratorQuiz.reset();
                            changeSeconds.value = widget.seconds!;
                          }
                        },
                        height: size.height,
                        width: size.width,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: size.width,
              height: size.width * 0.15,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38),
                    topLeft: Radius.circular(38),
                  ),
                ),
                child: Center(
                  child: Text(
                    "QUIZZLY",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
