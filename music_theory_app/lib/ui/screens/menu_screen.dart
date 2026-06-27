import 'package:flutter/material.dart';
import '../widgets/modern_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F11),
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Teoría Musical',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                        fontFamily: 'Outfit',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aprende y domina la lectura y construcción musical de forma interactiva y moderna.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white60,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'Ejercicios Disponibles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: const Color(0xCCFFFFFF),
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 1: Identificación de Notas
                    PremiumButton(
                      onPressed: () => Navigator.of(context).pushNamed('/exercise/note-identification'),
                      height: 110,
                      borderRadius: 24,
                      gradient: null,
                      backgroundColor: const Color(0xFF1E1E24),
                      border: Border.all(color: const Color(0xFF2E2E38)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.music_note_rounded,
                                color: Colors.deepPurpleAccent,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Identificación de Notas',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Lee notas en clave de Sol y de Fa.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white30,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 2: Intervalos (Próximamente)
                    Opacity(
                      opacity: 0.5,
                      child: PremiumButton(
                        onPressed: () {},
                        height: 110,
                        borderRadius: 24,
                        gradient: null,
                        backgroundColor: const Color(0xFF1E1E24),
                        border: Border.all(color: const Color(0xFF2E2E38)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.align_horizontal_left_rounded,
                                  color: Colors.blueAccent,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Intervalos Musicales',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Reconoce distancias entre notas. (Próximamente)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white60,
                                        fontFamily: 'Outfit',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white30,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
