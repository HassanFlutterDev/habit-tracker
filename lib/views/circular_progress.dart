import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../utils/color_resources.dart';

class CircularProgress extends CustomPainter {
  double radius, strokeWidth;
  int offSetDivider;
  AnimationController animationController;

  CircularProgress(
      {required this.radius,
      required this.strokeWidth,
      required this.offSetDivider,
      required this.animationController});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorResources.progressLightColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    // Offset center = Offset(size.width / offSetDivider, size.height / offSetDivider);
    // canvas.drawCircle(center, radius, circle);
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    // print("AnimationValue"+animationController.value.toString());
    double progress = (1.0 - animationController.value) * 2 * math.pi;

    paint.color = ColorResources.DARK_GREY.withOpacity(0.5);

    canvas.drawArc(Offset.zero & size, -1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
