import 'package:flutter/material.dart';

import 'home_dashboard.dart';

/// First screen of Namma Health: welcome + language choice.
///
/// Tapping a language opens the Home Dashboard and passes the
/// selected language. Full translation will be added later.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color _background = Color(0xFFEEF6F1);
  static const Color _primary = Color(0xFF1B7A6E);
  static const Color _primaryDark = Color(0xFF145E55);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _text = Color(0xFF1C2B28);

  static const List<String> languages = [
    'தமிழ்',
    'हिंदी',
    'తెలుగు',
    'ಕನ್ನಡ',
    'English',
  ];

  void _onLanguageSelected(BuildContext context, String languageName) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => HomeDashboard(selectedLanguage: languageName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
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
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      const _HealthcareIllustration(),
                      const SizedBox(height: 20),
                      const Text(
                        'Namma Health',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: _primaryDark,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your Health, Our Care',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: _primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _LanguageCard(
                        onLanguageSelected: (language) {
                          _onLanguageSelected(context, language);
                        },
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Healthcare made simple for everyone',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A635C),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
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

class _HealthcareIllustration extends StatelessWidget {
  const _HealthcareIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: WelcomeScreen._card,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: WelcomeScreen._primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.health_and_safety_rounded,
        size: 64,
        color: WelcomeScreen._primary,
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({required this.onLanguageSelected});

  final ValueChanged<String> onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        color: WelcomeScreen._card,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.volume_up_rounded,
                size: 32,
                color: WelcomeScreen._primary,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Choose your language',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: WelcomeScreen._text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (int i = 0; i < WelcomeScreen.languages.length; i++) ...[
            if (i > 0) const SizedBox(height: 14),
            _LanguageButton(
              label: WelcomeScreen.languages[i],
              onPressed: () {
                onLanguageSelected(WelcomeScreen.languages[i]);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: WelcomeScreen._primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
