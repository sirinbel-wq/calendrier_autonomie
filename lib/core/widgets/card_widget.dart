import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final Color color;

  const CardWidget({super.key, required this.child, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,3))],
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}