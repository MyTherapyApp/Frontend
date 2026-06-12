import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_therapy/features/auth/screens/onboarding_screen.dart';

import '../../features/admin/admin_cubit.dart';
import '../../features/admin/admin_pending_screen.dart';
import '../../features/admin/admin_remote_data_source_impl.dart';
import '../../features/admin/admin_repository_impl.dart';
import '../enums/user_role.dart';
import '../network/dio_client.dart';
import '../services/secure_storage_service.dart';
import 'main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: Duration(milliseconds: 5000), 
      backgroundColor: Colors.white,
      splashScreenBody: const _SplashContent(),
      nextScreen: const OnboardingScreen(),
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
      _testToken();
    _startAnimation();
     // NEW
    _checkAuth();

  }
  Future<void> _testToken() async {
  final token =
      await SecureStorageService()
          .getToken();

  debugPrint('TOKEN => $token');
}
  Future<void> _startAnimation() async {
    await _logoController.forward();

    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _textController.forward();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    final storage =
        SecureStorageService();

    final token =
        await storage.getToken();

    // NEW
    if (token == null) {
      _goToOnboarding();
      return;
    }
    // NEW
    if (JwtDecoder.isExpired(token)) {
      await storage.deleteToken();

      DioClient.dio.options.headers
          .remove('Authorization');

      _goToOnboarding();
      return;
    }
     // NEW: إعادة إضافة Authorization Header
    DioClient.dio.options.headers[
        'Authorization'] =
        'Bearer $token';

    final claims =
        JwtDecoder.decode(token);

    final role = claims[
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

    if (!mounted) return;

    // NEW: التوجيه حسب الرول
    if (role == 'Patient') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            role: UserRole.patient,
          ),
        ),
      );
    }

    else if (role == 'Therapist') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainScreen(
            role: UserRole.therapist,
          ),
        ),
      );
    }

    else if (role == 'Admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AdminCubit(
              AdminRepositoryImpl(
                AdminRemoteDataSourceImpl(),
              ),
            ),
            child:
                const AdminPendingScreen(),
          ),
        ),
      );
    }

    else {
      _goToOnboarding();
    }
  }

  // NEW: شاشة البداية للمستخدم غير المسجل
  void _goToOnboarding() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const OnboardingScreen(),
      ),
    );
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