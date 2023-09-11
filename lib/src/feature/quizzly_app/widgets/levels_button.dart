import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class LevelsButton extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final void Function() onPressed;

  const LevelsButton({
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  State<LevelsButton> createState() => _LevelsButtonState();
}

class _LevelsButtonState extends State<LevelsButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * 0.8,
      height: widget.height * 0.08,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColor.mainColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(color: AppColor.white, width: 3),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
