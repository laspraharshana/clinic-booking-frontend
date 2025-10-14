import 'package:flutter/material.dart';

import 'Signinandsignup.dart';

// Brand colors
const kPrimaryDark = Color(0xFF1B5E57);
const kPrimary = Color(0xFF06A27B);

class Skip3Screen extends StatelessWidget {
  final VoidCallback? onSkip;
  final VoidCallback? onGetStarted;
  final bool showPageCount;

  const Skip3Screen({
    super.key,
    this.onSkip,
    this.onGetStarted,
    this.showPageCount = true,
  });

  void _defaultFinish(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Get Started tapped (wire navigation)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageIndex = 2; // 0-based; page 3
    const pageCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Skip
            Positioned(
              top: 8,
              right: 16,
              child: TextButton(
                onPressed: onSkip ?? () => Navigator.maybePop(context),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Content
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 140),
              child: Column(
                children: const [
                  SizedBox(height: 12),
                  _HeroCircle(icon: Icons.timer_rounded), // stopwatch
                  SizedBox(height: 26),
                  _AccentCard(icon: Icons.medical_services_outlined),
                  SizedBox(height: 26),
                  _Title(),
                  SizedBox(height: 12),
                  _Description(),
                  SizedBox(height: 28),
                  _Dots(current: pageIndex, count: pageCount),
                ],
              ),
            ),

            // Bottom controls
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _GradientButton(
                      text: 'Get Started',
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInAndSignUp(),
                          ),
                        );
                      },
                    ),
                  ),
                  if (showPageCount) ...[
                    const SizedBox(height: 8),
                    const Text(
                      '3 of 3',
                      style: TextStyle(color: Colors.black38, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==== Text blocks ====

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Track Your Appointments',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        height: 1.25,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Real-time updates on your appointment status, queue position, '
        'and estimated waiting time.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54, height: 1.55, fontSize: 15),
      ),
    );
  }
}

// ==== Accent icon card ====

class _AccentCard extends StatelessWidget {
  final IconData icon;
  const _AccentCard({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, color: kPrimaryDark, size: 26),
    );
  }
}

// ==== Hero circle ====

class _HeroCircle extends StatelessWidget {
  final IconData icon;
  const _HeroCircle({required this.icon});

  @override
  Widget build(BuildContext context) {
    const size = 260.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Soft outer glow
        Container(
          width: size + 42,
          height: size + 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x3306A27B),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
        ),

        // Main circle
        ClipOval(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00CDA7), Color(0xFF009E86)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0.0, -0.08),
                      radius: 0.85,
                      colors: [Color(0x33FFFFFF), Colors.transparent],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: -0.55,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0x22FFFFFF), Colors.transparent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Inner plate icon
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 42),
        ),
      ],
    );
  }
}

// ==== Dots ====

class _Dots extends StatelessWidget {
  final int current;
  final int count;
  const _Dots({required this.current, required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final selected = i == current;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: selected ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: selected ? kPrimaryDark : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }),
      ),
    );
  }
}

// ==== Gradient button ====

class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? trailing;
  const _GradientButton({
    required this.text,
    required this.onPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [kPrimaryDark, kPrimary]),
        borderRadius: BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
