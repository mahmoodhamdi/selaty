// splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/cubits/onboarding/onboarding_cubit.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/helpers/first_time_helper.dart';
import 'package:selaty/features/auth/presentation/logic/login_status/login_status_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/login_status/login_status_state.dart';
import 'package:selaty/features/auth/presentation/views/auth_view.dart';
import 'package:selaty/features/home/presentation/views/main_view.dart';
import 'package:selaty/features/onboarding/presentation/views/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _shapeController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _shapeAnimation;
  late bool isFirst;
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimationSequence();
    isFirstTime();
  }

  Future<void> isFirstTime() async {
    isFirst = await FirstTimeHelper.isFirstTime();
  }

  void _setupAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _logoRotateAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    // Background shape animations
    _shapeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _shapeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shapeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _shapeController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.read<LoginStatusCubit>().checkLoginStatus();
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _shapeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shortestSide = size.shortestSide;

    return BlocListener<LoginStatusCubit, LoginStatusState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainView(),
              ));
        } else if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushReplacement(
              context,
              isFirst
                  ? MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => OnboardingCubit(),
                        child: const OnboardingView(),
                      ),
                    )
                  : MaterialPageRoute(builder: (context) => const AuthView()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Animated background shapes
            AnimatedBuilder(
              animation: _shapeAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundShapesPainter(
                    animation: _shapeAnimation.value,
                    isPortrait: isPortrait,
                  ),
                  size: size,
                );
              },
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _logoRotateAnimation.value * 3.14,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Container(
                            width: shortestSide * 0.4,
                            height: shortestSide * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(shortestSide * 0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryGreen.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(shortestSide * 0.2),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: shortestSide * 0.05),

                  // Animated text
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _textSlideAnimation.value),
                        child: Opacity(
                          opacity: _textFadeAnimation.value,
                          child: Column(
                            children: [
                              Text(
                                'ســـــــــــلتي',
                                style: TextStyle(
                                  fontSize: shortestSide * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: accentRedText,
                                ),
                              ),
                              SizedBox(height: shortestSide * 0.02),
                              Text(
                                'S E L A T Y',
                                style: TextStyle(
                                  fontSize: shortestSide * 0.04,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: shortestSide * 0.08),

                  // Loading indicator
                  SizedBox(
                    width: shortestSide * 0.1,
                    height: shortestSide * 0.1,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryGreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for background shapes
class BackgroundShapesPainter extends CustomPainter {
  final double animation;
  final bool isPortrait;

  BackgroundShapesPainter({
    required this.animation,
    required this.isPortrait,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // First wave
    final paint1 = Paint()
      ..color = primaryGreen.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
        size.width * 0.5 * animation,
        size.height * 0.3,
        size.width * animation,
        0,
      );

    // Second wave
    final paint2 = Paint()
      ..color = primaryBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(size.width, size.height)
      ..quadraticBezierTo(
        size.width * 0.5 * (1 - animation),
        size.height * 0.7,
        0,
        size.height,
      );

    // Decorative circles
    final circlePaint1 = Paint()
      ..color = secondaryOrange.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final circlePaint2 = Paint()
      ..color = secondarySkyBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);

    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.2),
      50 * animation,
      circlePaint1,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.8),
      70 * animation,
      circlePaint2,
    );
  }

  @override
  bool shouldRepaint(BackgroundShapesPainter oldDelegate) =>
      animation != oldDelegate.animation ||
      isPortrait != oldDelegate.isPortrait;
}
