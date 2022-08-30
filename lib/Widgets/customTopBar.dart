import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomTopBar extends StatelessWidget {
  final String barText;
  final double barWidth;
  final double barHeight;
  final double barRadius;
  const CustomTopBar(
      {Key? key,
      required this.barText,
      required this.barHeight,
      required this.barWidth,
      required this.barRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(barRadius),
      child: Container(
        height: barHeight,
        width: barWidth,
        decoration: const BoxDecoration(
          color: primaryTextColor,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              secondaryColor,
              primaryColor,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                barText,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, color: whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
