import 'package:flutter/material.dart';

class BubbleEnergyIndicator extends StatefulWidget {
  final double value;
  final Color color;
  final IconData icon;

  const BubbleEnergyIndicator({super.key,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  BubbleEnergyIndicatorState createState() => BubbleEnergyIndicatorState();
}

class BubbleEnergyIndicatorState extends State<BubbleEnergyIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500 + (widget.value * 10).toInt()),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 30, color: Colors.white),
              Text(
                widget.value.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}