import 'package:flutter/material.dart';

import '../Constants.dart';

class DetailsTileSelected extends StatefulWidget {
  final String imagePath;
  final String tileText;
  final String tileDescription;
  final String tileFee;
  const DetailsTileSelected(
      {Key? key,
      required this.imagePath,
      required this.tileText,
      required this.tileDescription,
      required this.tileFee})
      : super(key: key);

  @override
  State<DetailsTileSelected> createState() => _DetailsTileSelectedState();
}

class _DetailsTileSelectedState extends State<DetailsTileSelected> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          widget.imagePath,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.tileText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          Text(
                            widget.tileDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                        ],
                      ),
                    ])
                  ]),
                  Text(
                    widget.tileFee,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.green),
                  ),
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: primaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
