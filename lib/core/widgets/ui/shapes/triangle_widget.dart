import 'package:flutter/material.dart';

class AnimatedTriangleWidget extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final double angle;

  const AnimatedTriangleWidget({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.color = Colors.blue,
    this.angle = 0,
  });

  @override
  _AnimatedTriangleWidgetState createState() => _AnimatedTriangleWidgetState();
}

class _AnimatedTriangleWidgetState extends State<AnimatedTriangleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _scale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _rotation = Tween<double>(
      begin: 0.0, // Start rotation angle
      end: widget.angle, // Rotate to the final angle passed in the widget
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedBuilder(
          animation: _rotation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation.value, // Use the animated rotation value
              child: child,
            );
          },
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            painter: TrianglePainter(color: widget.color.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Top vertex
    path.lineTo(0, size.height); // Bottom left vertex
    path.lineTo(size.width, size.height); // Bottom right vertex
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
