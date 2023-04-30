import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPaint extends CustomPainter {
  double startX = 100 - 10.w;
  double startY = 200 - 110.h;
  double endX = 150 - 10.w;
  double endY = 200 - 110.h;
  MyPaint({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint startPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Paint endPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Path path = Path();
    path.moveTo(startX, startY);
    path.lineTo(endX, endY);

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(startX, startY), 10, startPaint);
    canvas.drawCircle(Offset(endX, endY), 10, endPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
