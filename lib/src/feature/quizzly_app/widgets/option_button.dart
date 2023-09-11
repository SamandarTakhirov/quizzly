import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class OptionButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final void Function() onPressed;

  const OptionButton({
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * 0.8,
      height: widget.height * 0.08,
      child: FilledButton(
        onPressed: widget.onPressed,
        style: FilledButton.styleFrom(
          foregroundColor: AppColor.mainColor,
          backgroundColor: AppColor.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
              color: AppColor.mainColor,
              width: 2,
            ),
          ),
        ),
       
        child: Text(
          widget.text,
          style: const TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
