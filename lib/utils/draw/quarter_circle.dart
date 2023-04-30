import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class QuarterCircle extends StatelessWidget {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCircle({
    this.color = Colors.grey,
    this.circleAlignment = CircleAlignment.topLeft,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRect(
        child: CustomPaint(
          painter: QuarterCirclePainter(
            circleAlignment: circleAlignment,
            color: color,
          ),
        ),
      ),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter(
      {required this.circleAlignment, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 50.w;
    final offset = circleAlignment == CircleAlignment.topLeft
        ? Offset(.0, .0)
        : circleAlignment == CircleAlignment.topRight
            ? Offset(size.width, .0)
            : circleAlignment == CircleAlignment.bottomLeft
                ? Offset(.0, size.height)
                : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);

    // Path path = Path();
    // path.moveTo(10, 10);
    // path.lineTo(30, 30);
    // canvas.drawPath(path, Paint()..color = Colors.yellow);

    // const arcCenter = Offset(10, 10);
    // final arcRect = Rect.fromCircle(center: arcCenter, radius: 10);
    // double startAngle = degreesToRadians(0);
    // double sweepAngle = degreesToRadians(90);
    // canvas.drawArc(
    //     arcRect, startAngle, sweepAngle, true, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }

  double degreesToRadians(double degree) {
    return degree * 3.141592 / 180;
  }
}
