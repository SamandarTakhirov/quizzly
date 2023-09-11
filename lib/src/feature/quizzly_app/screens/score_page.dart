import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../widgets/option_button.dart';
import 'home_page.dart';
import 'quiz_page.dart';

class ScorePage extends StatefulWidget {
  final int correct;
  final int? seconds;

  const ScorePage({
    Key? key,
    required this.correct,
    required this.seconds,
  }) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openHomePage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );

  void openQuizPage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(
            seconds: widget.seconds,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.mainColor,
            leading: IconButton(
              splashRadius: 25,
              onPressed: openHomePage,
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
                    height: size.height * 0.3,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: Center(
                          child: SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.45,
                            child: CircleAvatar(
                              backgroundColor: Colors.white30,
                              child: SizedBox(
                                width: size.width * 0.35,
                                height: size.height * 0.35,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white70,
                                  child: SizedBox(
                                    width: size.width * 0.3,
                                    height: size.height * 0.3,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Your Score",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.mainTextColor,
                                            ),
                                          ),
                                          Text(
                                            "${widget.correct * 10}",
                                            style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.mainTextColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.25,
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                    ),
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.15,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blurBlack,
                              spreadRadius: 0.5,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    "${widget.correct}",
                                    style: const TextStyle(
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Correct",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "${10 - widget.correct}",
                                    style: const TextStyle(
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Wrong",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.05),
              OptionButton(
                text: "Play again",
                onPressed: openQuizPage,
                height: size.height,
                width: size.width,
              ),
              SizedBox(height: size.height * 0.03),
              OptionButton(
                text: "Home",
                onPressed: openHomePage,
                height: size.height,
                width: size.width,
              ),
              const Spacer(),
              SizedBox(
                width: size.width,
                height: size.height * 0.08,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
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
              )
            ],
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirection: pi / 2,
          colors: Colors.accents,
          gravity: 0.01,
          emissionFrequency: 0.5,
        ),
      ],
    );
  }
}
