import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViews extends StatefulWidget {
  const PageViews({Key? key}) : super(key: key);

  @override
  State<PageViews> createState() => _PageViewsState();
}

class _PageViewsState extends State<PageViews> {
  final _list = [
    'assets/images/portrait_doctor.png',
    'assets/images/portrait_doctor.png',
    'assets/images/portrait_doctor.png',
    'assets/images/portrait_doctor.png',
  ];

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            padEnds: false,
            children: _list
                .map((e) => Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        e,
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: _list.length,
              effect: ScrollingDotsEffect(
                activeStrokeWidth: 10,
                dotHeight: 10,
                dotWidth: 10,
                activeDotScale: 1.4,
                radius: 8,
                spacing: 10,
              ),
            )
          ],
        )
      ],
    );
  }
}
