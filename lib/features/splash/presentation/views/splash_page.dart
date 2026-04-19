import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _masterController;
  late AnimationController _orbController;
  late AnimationController _dotsController;

  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _headlineFade;
  late Animation<Offset> _headlineSlide;
  late Animation<double> _loadingFade;

  @override
  void initState() {
    super.initState();

    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _logoFade = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    ));

    _headlineFade = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.2, 0.55, curve: Curves.easeOut),
    );
    _headlineSlide =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _masterController,
          curve: const Interval(0.2, 0.55, curve: Curves.easeOut),
        ));

    _loadingFade = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.70, 0.90, curve: Curves.easeOut),
    );

    _masterController.forward();

    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.home);
      }
    });
  }

  @override
  void dispose() {
    _masterController.dispose();
    _orbController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF061E47),
                  Color(0xFF0A3A8C),
                  Color(0xFF0B5BC5),
                  Color(0xFF2E8FE6),
                ],
                stops: [0.0, 0.38, 0.72, 1.0],
              ),
            ),
          ),

          // Subtle grid lines
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          // Animated orbs
          AnimatedBuilder(
            animation: _orbController,
            builder: (_, __) {
              return Stack(
                children: [
                  Positioned(
                    top: -80,
                    right: -100,
                    child: _GlowOrb(
                      size: 340,
                      color: const Color(0xFF6CC3FF),
                      opacity: 0.12 +
                          0.04 *
                              math.sin(
                                  _orbController.value * 2 * math.pi),
                    ),
                  ),
                  Positioned(
                    bottom: 160,
                    left: -80,
                    child: _GlowOrb(
                      size: 240,
                      color: const Color(0xFF2E8FE6),
                      opacity: 0.16 +
                          0.04 *
                              math.cos(
                                  _orbController.value * 2 * math.pi),
                    ),
                  ),
                ],
              );
            },
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Logo
                  FadeTransition(
                    opacity: _logoFade,
                    child: SlideTransition(
                      position: _logoSlide,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.blue.withValues(alpha: 0.2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  'assets/images/lms_logo1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BRAC Bank',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                Text(
                                  'LEGAL DIVISION',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 90),

                  // Headline
                  FadeTransition(
                    opacity: _headlineFade,
                    child: SlideTransition(
                      position: _headlineSlide,
                      child: Column(
                        children: [
                          Text(
                            'Litigation Management\nSystem',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Smart legal tracking, case insights,\nand compliance monitoring in one place.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.65),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),

                  const Spacer(),

                  // Loading Section
                  FadeTransition(
                    opacity: _loadingFade,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                            backgroundColor:
                            Colors.white.withValues(alpha: 0.2),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Preparing dashboard',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                            const SizedBox(width: 6),
                            _AnimatedDots(controller: _dotsController),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}

// Animated dots
class _AnimatedDots extends StatelessWidget {
  const _AnimatedDots({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Row(
          children: List.generate(3, (i) {
            final phase = (controller.value - i * 0.2).clamp(0.0, 1.0);
            final opacity = (math.sin(phase * math.pi)).clamp(0.3, 1.0);
            return Container(
              margin: const EdgeInsets.only(left: 3),
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}

// Glow orb
class _GlowOrb extends StatelessWidget {
  const _GlowOrb(
      {required this.size, required this.color, required this.opacity});
  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

// Grid painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 0.8;

    const step = 32.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
