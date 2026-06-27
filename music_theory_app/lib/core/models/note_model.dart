enum Clef { treble, bass }

class Note {
  final String pitchName; // C, D, E, F, G, A, B
  final int octave;       // Octava científica (e.g. 4 para C4)

  Note({required this.pitchName, required this.octave});

  // Traducción a nomenclatura tradicional en español
  String get spanishName {
    const Map<String, String> translations = {
      'C': 'Do',
      'D': 'Re',
      'E': 'Mi',
      'F': 'Fa',
      'G': 'Sol',
      'A': 'La',
      'B': 'Si',
    };
    return translations[pitchName] ?? pitchName;
  }

  @override
  String toString() => '$pitchName$octave';
}

class NoteEngine {
  static const List<String> diatonicScale = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  // Mapeo matemático del Step Index a una Nota
  static Note getNoteFromStep(int stepIndex, Clef clef) {
    // Clave de Sol: línea inferior (step 0) es Mi 4 (E4) -> Diatónico index 30 (E=2 + 4*7)
    // Clave de Fa: línea inferior (step 0) es Sol 2 (G2) -> Diatónico index 18 (G=4 + 2*7)
    final int baseDiatonicIndex = (clef == Clef.treble) ? 30 : 18;
    final int absoluteIndex = baseDiatonicIndex + stepIndex;

    final int octave = (absoluteIndex / 7).floor();
    final int pitchIndex = ((absoluteIndex % 7) + 7) % 7; // Módulo seguro
    final String pitchName = diatonicScale[pitchIndex];

    return Note(pitchName: pitchName, octave: octave);
  }
}
