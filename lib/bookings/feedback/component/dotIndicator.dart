import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

class DotIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  DotIndicator(
      {required this.controller,
      required this.itemCount,
      required this.onPageSelected,
      this.color: kAppIconColor})
      : super(listenable: controller);

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0.0,
          1.0 - ((controller.page ?? controller.initialPage) - index).abs()),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, _buildDot),
    );
  }
}
