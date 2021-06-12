import 'package:flutter/material.dart';

class ServiceCardBluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff232C63);
    path = Path();
    path.lineTo(size.width, size.height * 0.87);
    path.cubicTo(size.width, size.height * 0.94, size.width * 0.96, size.height,
        size.width * 0.9, size.height);
    path.cubicTo(size.width * 0.9, size.height, size.width * 0.1, size.height,
        size.width * 0.1, size.height);
    path.cubicTo(size.width * 0.03, size.height, -0.01, size.height * 0.92, 0,
        size.height * 0.84);
    path.cubicTo(0, size.height * 0.84, size.width * 0.13, size.height * 0.11,
        size.width * 0.13, size.height * 0.11);
    path.cubicTo(size.width * 0.14, size.height * 0.05, size.width * 0.18, 0,
        size.width * 0.22, 0);
    path.cubicTo(
        size.width * 0.22, 0, size.width * 0.9, 0, size.width * 0.9, 0);
    path.cubicTo(size.width * 0.96, 0, size.width, size.height * 0.06,
        size.width, size.height * 0.14);
    path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.87,
        size.width, size.height * 0.87);
    path.cubicTo(size.width, size.height * 0.87, size.width, size.height * 0.87,
        size.width, size.height * 0.87);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ServiceCardOrangePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Color(0xffFF7717);
    path = Path();
    path.lineTo(0, size.height * 0.14);
    path.cubicTo(
        0, size.height * 0.06, size.width * 0.04, 0, size.width * 0.1, 0);
    path.cubicTo(size.width * 0.1, 0, size.width * 0.9, 0, size.width * 0.9, 0);
    path.cubicTo(size.width * 0.97, 0, size.width, size.height * 0.08,
        size.width, size.height * 0.17);
    path.cubicTo(size.width, size.height * 0.17, size.width * 0.87,
        size.height * 0.9, size.width * 0.87, size.height * 0.9);
    path.cubicTo(size.width * 0.86, size.height * 0.96, size.width * 0.82,
        size.height, size.width * 0.78, size.height);
    path.cubicTo(size.width * 0.78, size.height, size.width * 0.1, size.height,
        size.width * 0.1, size.height);
    path.cubicTo(size.width * 0.04, size.height, 0, size.height * 0.94, 0,
        size.height * 0.87);
    path.cubicTo(
        0, size.height * 0.87, 0, size.height * 0.14, 0, size.height * 0.14);
    path.cubicTo(
        0, size.height * 0.14, 0, size.height * 0.14, 0, size.height * 0.14);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PricePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Colors.white;
    path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 10, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


