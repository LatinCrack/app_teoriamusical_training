import 'dart:math';
import 'package:flutter/material.dart';
import '../models/note_model.dart';

class ExerciseState {
  final Clef currentClef;
  final Note currentNote;
  final int stepIndex;
  final List<String> options;
  final String? userAnswer;
  final String feedbackStatus; // 'idle', 'correct', 'incorrect'
  final int correctCount;
  final int totalCount;
  final int streak;

  ExerciseState({
    required this.currentClef,
    required this.currentNote,
    required this.stepIndex,
    required this.options,
    this.userAnswer,
    required this.feedbackStatus,
    required this.correctCount,
    required this.totalCount,
    required this.streak,
  });

  ExerciseState copyWith({
    Clef? currentClef,
    Note? currentNote,
    int? stepIndex,
    List<String>? options,
    String? userAnswer,
    String? feedbackStatus,
    int? correctCount,
    int? totalCount,
    int? streak,
  }) {
    return ExerciseState(
      currentClef: currentClef ?? this.currentClef,
      currentNote: currentNote ?? this.currentNote,
      stepIndex: stepIndex ?? this.stepIndex,
      options: options ?? this.options,
      userAnswer: userAnswer ?? this.userAnswer,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      correctCount: correctCount ?? this.correctCount,
      totalCount: totalCount ?? this.totalCount,
      streak: streak ?? this.streak,
    );
  }
}

class GameEngine extends ChangeNotifier {
  late ExerciseState state;
  final Random _random = Random();

  GameEngine() {
    _initNewGame(Clef.treble);
  }

  void _initNewGame(Clef clef, {int correct = 0, int total = 0, int streak = 0}) {
    // Generar un stepIndex aleatorio en el rango [-4, 12] (2 líneas adicionales abajo/arriba)
    final int stepIndex = _random.nextInt(17) - 4; // Genera entre -4 y 12
    final Note note = NoteEngine.getNoteFromStep(stepIndex, clef);

    // Mostrar siempre las 7 notas en orden natural
    final List<String> options = ['Do', 'Re', 'Mi', 'Fa', 'Sol', 'La', 'Si'];

    state = ExerciseState(
      currentClef: clef,
      currentNote: note,
      stepIndex: stepIndex,
      options: options,
      feedbackStatus: 'idle',
      correctCount: correct,
      totalCount: total,
      streak: streak,
    );
  }

  void selectClef(Clef clef) {
    _initNewGame(clef,
        correct: state.correctCount,
        total: state.totalCount,
        streak: state.streak);
    notifyListeners();
  }

  void submitAnswer(String answer) {
    if (state.feedbackStatus != 'idle') return; // Evitar doble envío

    final bool isCorrect = answer == state.currentNote.spanishName;
    final int nextCorrect = isCorrect ? state.correctCount + 1 : state.correctCount;
    final int nextTotal = state.totalCount + 1;
    final int nextStreak = isCorrect ? state.streak + 1 : 0;

    state = state.copyWith(
      userAnswer: answer,
      feedbackStatus: isCorrect ? 'correct' : 'incorrect',
      correctCount: nextCorrect,
      totalCount: nextTotal,
      streak: nextStreak,
    );
    notifyListeners();
  }

  void nextQuestion() {
    _initNewGame(
      state.currentClef,
      correct: state.correctCount,
      total: state.totalCount,
      streak: state.streak,
    );
    notifyListeners();
  }
}
