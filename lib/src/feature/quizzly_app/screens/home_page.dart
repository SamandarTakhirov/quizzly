import 'package:flutter/material.dart';
import 'package:quizzly/src/common/constants/app_pictures.dart';

import '../../../common/constants/app_colors.dart';
import '../widgets/levels_button.dart';
import 'quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> levels = const [
    QuizPage(seconds: null),
    QuizPage(seconds: 20),
    QuizPage(seconds: 10),
  ];
  void openLevelOnePage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuizPage(seconds: null),
        ),
      );

  void openQuizPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => levels[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppPictures.imgBkg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.04),
                const Text(
                  "QUIZZLY",
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 67,
                      fontFamily: "ExpletusSans"),
                ),
                SizedBox(height: size.height * 0.04),
                SizedBox(
                  height: size.height * 0.23,
                  width: size.width * 0.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.white20,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        )
                      ],
                      color: AppColor.white90,
                      borderRadius: BorderRadius.all(
                        Radius.circular(size.height * .02),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Welcome to Quizzly!",
                          style: TextStyle(
                            color: AppColor.mainTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        Text(
                          "With Quizzly, you can improve your thinking, intelligence and logical skills.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.mainTextColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                const Text(
                  "Choose the appropriate level...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Column(
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.015),
                      child: LevelsButton(
                        onPressed: () => openQuizPage(index),
                        text: "Level ${index + 1}",
                        width: size.width,
                        height: size.height,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
