import 'package:flutter/material.dart';
import '../../ui/screens/menu_screen.dart';
import '../../ui/screens/note_quiz_screen.dart';
import '../../ui/widgets/exercise_wrapper.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => const MenuScreen(),
      '/exercise/note-identification': (context) => const ExerciseWrapper(
            title: 'Identificación de Notas',
            child: NoteQuizScreen(),
          ),
    };
  }
}
