import 'package:flutter/material.dart';
import 'package:my_therapy/auth/screens/role_selection/role_selection_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: Duration(milliseconds: 6000), 
      backgroundColor: Colors.white,
      splashScreenBody: const _SplashContent(),
      nextScreen: RoleSelectionScreen(), 
    );
  }
}

class _SplashContent extends StatefulWidget {
  const _SplashContent();

  @override
  State<_SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContent>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  late Animation<double> _mindCareOpacity;
  late Animation<double> _titleOpacity;

  @override
  void initState() {
    super.initState();

    /// LOGO ANIMATION
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoScale = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    /// TEXT ANIMATION
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _mindCareOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _titleOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 300));

    _textController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_logoController, _textController]),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LOGO
              Transform.scale(
                scale: _logoScale.value,
                child: Opacity(
                  opacity: _logoOpacity.value,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 180,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// MIND CARE
              Opacity(
                opacity: _mindCareOpacity.value,
                child: const Text(
                  "MIND CARE",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              /// My Therapy
              Opacity(
                opacity: _titleOpacity.value,
                child: const Text(
                  "My Therapy",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}