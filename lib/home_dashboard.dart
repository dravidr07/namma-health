import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'placeholder_screen.dart';

/// Home shown after a language is chosen.
class HomeDashboard extends StatefulWidget {
  const HomeDashboard({
    super.key,
    required this.selectedLanguage,
  });

  final String selectedLanguage;

  static const Color background = Color(0xFFEEF6F1);
  static const Color primary = Color(0xFF1B7A6E);
  static const Color primaryDark = Color(0xFF145E55);
  static const Color card = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF1C2B28);
  static const Color emergency = Color(0xFFC0392B);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _tabIndex = 0;

  void _openPlaceholder(String title, String message) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PlaceholderScreen(
          title: title,
          message: message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeDashboard.background,
      body: SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: [
            _HomeTab(
              selectedLanguage: widget.selectedLanguage,

              // AI Health Assistant now opens the real ChatScreen.
              onAskAssistant: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },

              // Other features remain placeholders for now.
              onNearbyHospitals: () {
                _openPlaceholder(
                  'Nearby Hospitals',
                  'Hospital and PHC finder will be available here.',
                );
              },
              onDoctorAppointment: () {
                _openPlaceholder(
                  'Doctor Appointment',
                  'Appointment booking will be available here.',
                );
              },
              onMyMedicines: () {
                _openPlaceholder(
                  'My Medicines',
                  'Medicine reminders will be available here.',
                );
              },
              onHealthRecords: () {
                _openPlaceholder(
                  'Health Records',
                  'Digital health records will be available here.',
                );
              },
              onEmergencySos: () {
                _openPlaceholder(
                  'Emergency SOS',
                  'Emergency assistance will be available here.',
                );
              },
            ),

            const _SimpleTabPlaceholder(
              title: 'Health',
              message: 'Your health information will be available here.',
            ),

            const _SimpleTabPlaceholder(
              title: 'Profile',
              message: 'Your profile will be available here.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 72,
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        backgroundColor: HomeDashboard.card,
        indicatorColor: HomeDashboard.primary.withValues(alpha: 0.16),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 30),
            selectedIcon: Icon(Icons.home_rounded, size: 30),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline, size: 30),
            selectedIcon: Icon(Icons.favorite_rounded, size: 30),
            label: 'Health',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: 30),
            selectedIcon: Icon(Icons.person_rounded, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({
    required this.selectedLanguage,
    required this.onAskAssistant,
    required this.onNearbyHospitals,
    required this.onDoctorAppointment,
    required this.onMyMedicines,
    required this.onHealthRecords,
    required this.onEmergencySos,
  });

  final String selectedLanguage;
  final VoidCallback onAskAssistant;
  final VoidCallback onNearbyHospitals;
  final VoidCallback onDoctorAppointment;
  final VoidCallback onMyMedicines;
  final VoidCallback onHealthRecords;
  final VoidCallback onEmergencySos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth =
            constraints.maxWidth > 520 ? 480 : constraints.maxWidth;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _WelcomeHeader(
                    selectedLanguage: selectedLanguage,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'How can we help you?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: HomeDashboard.primaryDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Opens ChatScreen.
                  _AssistantCard(
                    onTap: onAskAssistant,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.local_hospital_rounded,
                          label: 'Nearby Hospitals',
                          onTap: onNearbyHospitals,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.calendar_month_rounded,
                          label: 'Doctor Appointment',
                          onTap: onDoctorAppointment,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.medication_rounded,
                          label: 'My Medicines',
                          onTap: onMyMedicines,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.folder_shared_rounded,
                          label: 'Health Records',
                          onTap: onHealthRecords,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _EmergencyCard(
                    onTap: onEmergencySos,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({
    required this.selectedLanguage,
  });

  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: HomeDashboard.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: HomeDashboard.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety_rounded,
              size: 36,
              color: HomeDashboard.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A635C),
                  ),
                ),
                const Text(
                  'Namma Health',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: HomeDashboard.primaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selected language: $selectedLanguage',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: HomeDashboard.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HomeDashboard.primary,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 22, 20, 22),
          child: Row(
            children: [
              Icon(
                Icons.mic_rounded,
                size: 44,
                color: Colors.white,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ask Health Assistant',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Speak or type your health question',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HomeDashboard.card,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          constraints: const BoxConstraints(minHeight: 132),
          padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: HomeDashboard.primary,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboard.text,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HomeDashboard.emergency,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sos_rounded,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(width: 12),
              Flexible(
                child: Text(
                  'EMERGENCY SOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleTabPlaceholder extends StatelessWidget {
  const _SimpleTabPlaceholder({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          decoration: BoxDecoration(
            color: HomeDashboard.card,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: HomeDashboard.primaryDark,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.4,
                  color: HomeDashboard.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}