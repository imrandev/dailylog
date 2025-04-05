import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dailylog/core/utils/app_colors.dart';

/*const foregroundWaveColor = Color(0xFF4CAF50);
const backgroundWaveColor = Color(0xFF8BC34A);*/

const foregroundWaveColor = Colors.black12;
const backgroundWaveColor = AppColors.secondary;

class WaveProgressBar extends StatefulWidget {

  final double value;

  final double maxValue;

  final double height;

  final double? radius;

  const WaveProgressBar({
    super.key,
    required this.value,
    this.maxValue = 100.0,
    this.height = 40.0,
    this.radius,
  });

  @override
  WaveProgressBarState createState() => WaveProgressBarState();
}

class WaveProgressBarState extends State<WaveProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _waveAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(_waveController)
      ..addListener(() {
        setState(() {}); // This is crucial for animation updates
      });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (widget.value / widget.maxValue).clamp(0.0, 1.0);

    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        size: Size.infinite,
        painter: RectangleWavePainter(
          progress: percentage,
          waveAnimationValue: _waveAnimation.value,
          height: widget.height,
          radius: widget.radius,
        ),
      ),
    );
  }
}

class RectangleWavePainter extends CustomPainter {

  final double progress;

  final double waveAnimationValue;

  final double height;

  final double? radius;

  RectangleWavePainter({
    required this.progress,
    required this.waveAnimationValue,
    required this.height,
    this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Clip to rounded rectangle
    final clipPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius ?? (height / 2)),
        ),
      );
    canvas.clipPath(clipPath);

    // Draw background wave
    _drawWave(canvas, size, backgroundWaveColor);

    // Draw foreground wave (mirrored)
    _drawWave(canvas, size, foregroundWaveColor, mirror: true);
  }

  void _drawWave(Canvas canvas, Size size, Color color, {bool mirror = false}) {
    if (mirror) {
      canvas.save();
      canvas.scale(-1, 1);
      canvas.translate(-size.width, 0);
    }

    final waveHeight = height * 0.3;
    final amplitude = waveHeight * 0.5;
    const frequency = 0.05;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    // Create wave points
    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height -
          (size.height * progress) +
          amplitude * sin(frequency * x + waveAnimationValue);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    if (mirror) canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RectangleWavePainter oldDelegate) {
    return progress != oldDelegate.progress ||
        waveAnimationValue != oldDelegate.waveAnimationValue ||
        height != oldDelegate.height;
  }
}