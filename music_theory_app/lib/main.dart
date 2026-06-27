import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      ),
      initialRoute: '/',
      routes: AppRouter.routes,
    );
  }
}
