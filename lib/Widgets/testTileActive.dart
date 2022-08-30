import 'package:flutter/material.dart';

import '../Constants.dart';

class TestTileActive extends StatefulWidget {
  final String testTileActiveText;
  const TestTileActive({Key? key, required this.testTileActiveText})
      : super(key: key);

  @override
  State<TestTileActive> createState() => _TestTileActiveState();
}

class _TestTileActiveState extends State<TestTileActive> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Material(
            child: InkWell(
              // onTap: (() {}),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.testTileActiveText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 30,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            color: Colors.transparent,
          )),
    );
  }
}
