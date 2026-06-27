import "dart:io";
import "dart:ui" as ui;
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:music_theory_app/rendering/staff_painter.dart";
import "package:music_theory_app/core/models/note_model.dart";

void main() {
  testWidgets("render staff", (tester) async {
    final painter = StaffPainter(stepIndex: 4, clef: Clef.bass);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    painter.paint(canvas, const Size(600, 200));
    final picture = recorder.endRecording();
    final image = await picture.toImage(600, 200);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File("test_render.png");
    await file.writeAsBytes(byteData!.buffer.asUint8List());
  });
}
