part of '../animation_kit.dart';

class GlowingSpinAnimation extends StatefulWidget {
  const GlowingSpinAnimation({Key? key}) : super(key: key);
  @override
  State<GlowingSpinAnimation> createState() => _GlowingSpinAnimationState();
}

class _GlowingSpinAnimationState extends State<GlowingSpinAnimation> {
  int activeSpinIndex = 0;
  @override
  initState() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (activeSpinIndex == 12) {
        activeSpinIndex = 1;
      } else {
        activeSpinIndex = activeSpinIndex + 1;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GlowingSpinAnimationPainter(activeSpinIndex: activeSpinIndex),
    );
  }
}

class GlowingSpinAnimationPainter extends CustomPainter {
  int activeSpinIndex;
  static const double baseSize = 400.0;
  GlowingSpinAnimationPainter({required this.activeSpinIndex});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.shortestSide / baseSize;
    _drawIndicators(canvas, size, scaleFactor);
  }

  @override
  bool shouldRepaint(GlowingSpinAnimationPainter oldDelegate) {
    return oldDelegate.activeSpinIndex != activeSpinIndex;
  }

  void _drawIndicators(Canvas canvas, Size size, double scaleFactor) {
    double padding = 12.0;
    padding += 24.0;

    double radius = size.shortestSide / 2;
    double longHandLength = radius - (padding * scaleFactor);

    for (var index = 1; index <= 12; index++) {
      double angle = (index * pi / 6) - pi / 2;
      Offset offset = Offset(
          (longHandLength * cos(angle)) + longHandLength + 20,
          (longHandLength * sin(angle)) + longHandLength + 20);
      Offset shadowOffset = Offset(
          (longHandLength * cos(angle)) + longHandLength + 20,
          (longHandLength * sin(angle)) + longHandLength - 10);
      var path = Path();
      final newPaint = Paint()
        ..shader = const RadialGradient(colors: [
          // Colors.blue,
          Color(0xffe4fec9),
          Color(0xffbbff78),
          Color(0xff92ff26),
          Color(0xff69d400),
        ]).createShader(Rect.fromCircle(center: offset, radius: 75));
      canvas.drawCircle(offset, activeSpinIndex == index ? 15 : 8, newPaint);
      path.addOval(Rect.fromCircle(
        center: shadowOffset,
        radius: activeSpinIndex == index ? 30 : 16,
      ));
      // canvas.drawPath(path, Paint()..color = Colors.white);
      canvas.drawShadow(path, Colors.green, 60, false);
      // canvas.drawShadow(path, Colors.green, 30, false);
    }
  }
}
