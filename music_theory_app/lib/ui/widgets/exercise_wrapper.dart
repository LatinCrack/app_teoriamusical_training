import 'package:flutter/material.dart';

class ExerciseWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? headerActions;

  const ExerciseWrapper({
    super.key,
    required this.title,
    required this.child,
    this.headerActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F11),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            fontFamily: 'Outfit',
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E24),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E2E38)),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white70),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ),
        leadingWidth: 64,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.4,
            colors: [
              Color(0xFF191428),
              Color(0xFF0F0F11),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    if (headerActions != null) ...[
                      headerActions!,
                      const SizedBox(height: 16),
                    ],
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
