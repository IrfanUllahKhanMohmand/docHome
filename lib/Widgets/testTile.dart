import 'dart:developer';

import 'package:flutter/material.dart';

import '../Constants.dart';

class TestTile extends StatefulWidget {
  final String testTileText;
  const TestTile({Key? key, required this.testTileText}) : super(key: key);

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
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
              // onTap: (() {
              //   log("${widget.testTileText}");
              // }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.testTileText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            color: Colors.transparent,
          )),
    );
  }
}
