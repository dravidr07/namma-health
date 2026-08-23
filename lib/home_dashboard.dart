import 'package:flutter/material.dart';

/// Simple home screen shown after a language is chosen.
///
/// The dashboard stays in English for now, except for the
/// selected language label.
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  static const Color _background = Color(0xFFEEF6F1);
  static const Color _primary = Color(0xFF1B7A6E);
  static const Color _primaryDark = Color(0xFF145E55);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _text = Color(0xFF1C2B28);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth > 520 ? 480 : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: _card,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _primary.withValues(alpha: 0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.home_rounded,
                          size: 60,
                          color: _primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Welcome to Namma Health',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: _primaryDark,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          'Selected language: $selectedLanguage',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: _text,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
