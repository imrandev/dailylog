import 'package:flutter/material.dart';

class ElectricBoltIndicator extends StatefulWidget {
  final double value;

  const ElectricBoltIndicator({super.key, required this.value});

  @override
  ElectricBoltIndicatorState createState() => ElectricBoltIndicatorState();
}

class ElectricBoltIndicatorState extends State<ElectricBoltIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: const Icon(
              Icons.electric_bolt,
              size: 60,
              color: Colors.amber,
            ),
          ),
        );
      },
    );
  }
}