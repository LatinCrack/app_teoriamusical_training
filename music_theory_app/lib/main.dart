import 'package:flutter/material.dart';
import 'core/navigation/app_router.dart';

void main() {
  runApp(const NoteQuizApp());
}

class NoteQuizApp extends StatelessWidget {
  const NoteQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teoría Musical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F11),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: Brightness.dark,
        ),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Outfit'),
      ),
      initialRoute: '/',
      routes: AppRouter.routes,
    );
  }
}
