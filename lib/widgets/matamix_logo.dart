import 'package:flutter/material.dart';

class MatamixLogo extends StatelessWidget {
  final double size;

  const MatamixLogo({
    super.key,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MatamixLogoPainter(),
      ),
    );
  }
}

class MatamixLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Left Pillar (Dark Navy Blue)
    final paintDarkBlue = Paint()
      ..color = const Color(0xFF072146)
      ..style = PaintingStyle.fill;

    final pathDark = Path()
      ..moveTo(w * 0.12, h * 0.88)
      ..lineTo(w * 0.38, h * 0.88)
      ..lineTo(w * 0.38, h * 0.32)
      ..quadraticBezierTo(w * 0.38, h * 0.15, w * 0.25, h * 0.12)
      ..quadraticBezierTo(w * 0.12, h * 0.15, w * 0.12, h * 0.32)
      ..close();
    canvas.drawPath(pathDark, paintDarkBlue);

    // 2. Middle Pillar (Vibrant Blue)
    final paintBlue = Paint()
      ..color = const Color(0xFF007BFF)
      ..style = PaintingStyle.fill;

    final pathBlue = Path()
      ..moveTo(w * 0.44, h * 0.88)
      ..lineTo(w * 0.68, h * 0.88)
      ..lineTo(w * 0.68, h * 0.35)
      ..quadraticBezierTo(w * 0.68, h * 0.25, w * 0.56, h * 0.25)
      ..quadraticBezierTo(w * 0.44, h * 0.25, w * 0.44, h * 0.35)
      ..close();
    canvas.drawPath(pathBlue, paintBlue);

    // 3. Right Pillar (Teal)
    final paintTeal = Paint()
      ..color = const Color(0xFF00B09B)
      ..style = PaintingStyle.fill;

    final pathTeal = Path()
      ..moveTo(w * 0.74, h * 0.72)
      ..lineTo(w * 0.94, h * 0.72)
      ..lineTo(w * 0.94, h * 0.40)
      ..quadraticBezierTo(w * 0.94, h * 0.32, w * 0.84, h * 0.32)
      ..quadraticBezierTo(w * 0.74, h * 0.32, w * 0.74, h * 0.40)
      ..close();
    canvas.drawPath(pathTeal, paintTeal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
