import 'package:flutter/material.dart';

class PremiumButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final List<Color>? gradient;
  final double borderRadius;
  final double? width;
  final double height;
  final List<BoxShadow>? shadow;
  final Border? border;

  const PremiumButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = const Color(0xFF1E1E24),
    this.gradient = const [Color(0xFF6C63FF), Color(0xFF9D4EDD)],
    this.borderRadius = 20.0,
    this.width,
    this.height = 56.0,
    this.shadow,
    this.border,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.gradient == null ? widget.backgroundColor : null,
            gradient: widget.gradient != null
                ? LinearGradient(
                    colors: widget.gradient!,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: widget.shadow ??
                [
                  BoxShadow(
                    color: widget.gradient != null
                        ? widget.gradient!.first.withOpacity(0.3)
                        : Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
            border: widget.border ??
                Border.all(
                  color: Colors.white12,
                  width: 1.0,
                ),
          ),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
