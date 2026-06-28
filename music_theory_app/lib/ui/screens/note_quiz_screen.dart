import 'package:flutter/material.dart';
import '../../core/models/note_model.dart';
import '../../core/state/game_engine.dart';
import '../../rendering/staff_painter.dart';
import '../widgets/modern_button.dart';

class FadeScaleTransitionBuilder {
  static Widget build(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }
}

class NoteQuizScreen extends StatefulWidget {
  const NoteQuizScreen({super.key});

  @override
  State<NoteQuizScreen> createState() => _NoteQuizScreenState();
}

class _NoteQuizScreenState extends State<NoteQuizScreen> {
  final GameEngine _engine = GameEngine();

  @override
  void initState() {
    super.initState();
    _engine.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = _engine.state;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Selector de Clave y Banner de Score (Header del ejercicio)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E24),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF2E2E38)),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildClefButton(Clef.treble, 'Clave Sol', state.currentClef),
                    const SizedBox(width: 4),
                    _buildClefButton(Clef.bass, 'Clave Fa', state.currentClef),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E24),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF2E2E38)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Racha: ${state.streak} 🔥',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Puntos: ${state.correctCount}/${state.totalCount}',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Outfit',
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 32),

          // 2. Pentagrama Renderizado
          Card(
            elevation: 12,
            shadowColor: Colors.black.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                height: 240,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomPaint(
                  painter: StaffPainter(
                    stepIndex: state.stepIndex,
                    clef: state.currentClef,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 3. Feedback Inmediato (AnimatedSwitcher)
          SizedBox(
            height: 60,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: FadeScaleTransitionBuilder.build,
              child: state.feedbackStatus == 'idle'
                  ? const SizedBox.shrink(key: ValueKey('idle'))
                  : Container(
                      key: ValueKey(state.feedbackStatus),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                      decoration: BoxDecoration(
                        color: state.feedbackStatus == 'correct'
                            ? Colors.green.withOpacity(0.12)
                            : Colors.red.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: state.feedbackStatus == 'correct'
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        state.feedbackStatus == 'correct'
                            ? '¡Excelente Acierto! 🎉'
                            : 'Incorrecto (Era: ${state.currentNote.spanishName}) 😢',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Outfit',
                          color: state.feedbackStatus == 'correct'
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 32),

          // 4. Botones de Selección / Siguiente (Con tamaño animado para evitar saltos de layout)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: FadeScaleTransitionBuilder.build,
              child: state.feedbackStatus == 'idle'
                ? LayoutBuilder(
                    key: const ValueKey('options'),
                    builder: (context, constraints) {
                      final double spacing = 12.0;
                      final int columns = constraints.maxWidth > 450 ? 4 : 3;
                      final double buttonWidth =
                          (constraints.maxWidth - (columns - 1) * spacing) / columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        alignment: WrapAlignment.center,
                        children: state.options.map((option) {
                          return PremiumButton(
                            onPressed: () => _engine.submitAnswer(option),
                            width: buttonWidth,
                            height: 52,
                            borderRadius: 20,
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontFamily: 'Outfit',
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  )
                : Container(
                    key: const ValueKey('next_button'),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PremiumButton(
                      onPressed: _engine.nextQuestion,
                      height: 60,
                      borderRadius: 20,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Siguiente Nota',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: Colors.white,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                  ),
          ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildClefButton(Clef clef, String label, Clef activeClef) {
    final bool isSelected = clef == activeClef;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _engine.selectClef(clef),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Outfit',
          ),
        ),
      ),
    );
  }
}
