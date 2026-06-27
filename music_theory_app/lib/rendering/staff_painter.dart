import 'package:flutter/material.dart';
import '../core/models/note_model.dart';

class StaffPainter extends CustomPainter {
  final int stepIndex;
  final Clef clef;

  StaffPainter({required this.stepIndex, required this.clef});

  @override
  void paint(Canvas canvas, Size size) {
    final double yCenter = size.height / 2;
    final double xNote = size.width / 2 + 30; // Desplazar la nota a la derecha de la clave
    final double ySpacing = 20.0;             // Espacio entre líneas del pentagrama
    final double stepSize = ySpacing / 2;     // Espacio entre línea y espacio

    final Paint linePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Paint notePaint = Paint()
      ..color = Colors.blueGrey[800]!
      ..style = PaintingStyle.fill;

    // 1. Dibujar las 5 líneas principales del pentagrama
    for (int i = 0; i < 5; i++) {
      // Línea 1 (inferior) en yCenter + 2 * ySpacing
      // Línea 5 (superior) en yCenter - 2 * ySpacing
      final double y = yCenter + (2 - i) * ySpacing;
      canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), linePaint);
    }

    // 2. Calcular la posición Y de la nota
    // stepIndex 4 corresponde a la línea del centro (Línea 3)
    final double yNote = yCenter - (stepIndex - 4) * stepSize;

    // 3. Dibujar líneas adicionales dinámicas (Ledger Lines)
    final double ledgerLineWidth = 40.0;

    // Líneas adicionales inferiores (stepIndex <= -2)
    if (stepIndex <= -2) {
      canvas.drawLine(
        Offset(xNote - ledgerLineWidth / 2, yCenter + 6 * stepSize),
        Offset(xNote + ledgerLineWidth / 2, yCenter + 6 * stepSize),
        linePaint,
      );
      if (stepIndex <= -4) {
        canvas.drawLine(
          Offset(xNote - ledgerLineWidth / 2, yCenter + 8 * stepSize),
          Offset(xNote + ledgerLineWidth / 2, yCenter + 8 * stepSize),
          linePaint,
        );
      }
    }

    // Líneas adicionales superiores (stepIndex >= 10)
    if (stepIndex >= 10) {
      canvas.drawLine(
        Offset(xNote - ledgerLineWidth / 2, yCenter - 6 * stepSize),
        Offset(xNote + ledgerLineWidth / 2, yCenter - 6 * stepSize),
        linePaint,
      );
      if (stepIndex >= 12) {
        canvas.drawLine(
          Offset(xNote - ledgerLineWidth / 2, yCenter - 8 * stepSize),
          Offset(xNote + ledgerLineWidth / 2, yCenter - 8 * stepSize),
          linePaint,
        );
      }
    }

    // 4. Dibujar la nota (óvalo inclinado)
    canvas.save();
    canvas.translate(xNote, yNote);
    canvas.rotate(-0.25); // Inclinación tradicional de la cabeza de la nota
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 22, height: 15),
      notePaint,
    );
    canvas.restore();

    // 5. Dibujar la clave (Sol o Fa) usando la fuente profesional Bravura (SMuFL)
    final String clefSymbol = clef == Clef.treble ? '\u{E050}' : '\u{E062}';
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: clefSymbol,
        style: const TextStyle(
          fontFamily: 'Bravura',
          fontSize: 80.0,
          color: Colors.black87,
          height: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    final double baseline = textPainter.computeDistanceToActualBaseline(TextBaseline.alphabetic);
    
    // LA REVELACIÓN DE SMUFL:
    // En las fuentes SMuFL, la "línea base" (baseline) de cada clave NO es el fondo del pentagrama.
    // La línea base de una clave es EXACTAMENTE la línea musical que esa clave define.
    // - Clave de Sol (Treble): Define la nota Sol en la 2da línea desde abajo.
    // - Clave de Fa (Bass): Define la nota Fa en la 4ta línea desde abajo.
    
    double targetY;
    if (clef == Clef.treble) {
      // Línea 2 desde abajo (Sol)
      targetY = yCenter + 1.0 * ySpacing; // yCenter + 20
    } else {
      // Línea 4 desde abajo (Fa)
      targetY = yCenter - 1.0 * ySpacing; // yCenter - 20
    }

    final double yOffset = targetY - baseline;
    textPainter.paint(canvas, Offset(20, yOffset));
  }

  @override
  bool shouldRepaint(covariant StaffPainter oldDelegate) {
    return oldDelegate.stepIndex != stepIndex || oldDelegate.clef != clef;
  }
}
