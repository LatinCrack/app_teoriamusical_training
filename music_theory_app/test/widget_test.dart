import 'package:flutter_test/flutter_test.dart';
import 'package:music_theory_app/main.dart';

void main() {
  testWidgets('Smoke test for NoteQuizApp', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NoteQuizApp());

    // Verify that the title is present.
    expect(find.text('Identificación de Notas'), findsOneWidget);
  });
}
