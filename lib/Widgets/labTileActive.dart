import 'package:flutter/material.dart';

import '../Constants.dart';

class LabTileActive extends StatefulWidget {
  final String labTileActiveText;
  const LabTileActive({Key? key, required this.labTileActiveText})
      : super(key: key);

  @override
  State<LabTileActive> createState() => _LabTileActiveState();
}

class _LabTileActiveState extends State<LabTileActive> {
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
              //   setState(() {
              //     widget.selected = !widget.selected;
              //   });
              // }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.labTileActiveText,
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
    ;
  }
}
