import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/study/presentation/screens/study_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/study/domain/entities/flashcard.dart';
import '../theme/app_colors.dart';

class AppRouter {
  static const String loginPath = '/login';
  static const String homePath = '/';
  static const String studyPath = '/study';
  static const String profilePath = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: loginPath,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final bool loggingIn = state.matchedLocation == loginPath;

      if (authState is AuthUnauthenticated) {
        return loginPath;
      }

      if (authState is AuthAuthenticated) {
        if (loggingIn) return homePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: loginPath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: homePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: studyPath,
        builder: (context, state) {
          final card = Flashcard(
            id: '1',
            front: '猫',
            back: 'Cat',
            lastReview: DateTime.now(),
            nextReview: DateTime.now(),
          );
          return StudyScreen(card: card, onResult: (result) => context.pop());
        },
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.sakuraPink.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.local_florist, size: 60, color: AppColors.sakuraDeepPink),
              ),
              const SizedBox(height: 32),
              const Text('SakuraDrill', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              const SizedBox(height: 8),
              const Text('Learn Japanese one petal at a time', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
              const SizedBox(height: 64),
              
              // Social Buttons
              _socialButton('Continue with Google', Icons.g_mobiledata, Colors.white, AppColors.textMain, showBorder: true),
              const SizedBox(height: 16),
              _socialButton('Continue with Facebook', Icons.facebook, const Color(0xFF1877F2), Colors.white),
              
              const SizedBox(height: 32),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('OR', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 32),
              
              // Email Login Button
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const LoginRequested('fajar.dev@sakuradrill.jp', 'password'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0A6AB), // Gradient start color from design
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.2),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.white),
                    SizedBox(width: 12),
                    Text('Login with Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(text: "Start Your Journey", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain)),
                  ],
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text('Privacy Policy   Terms of Service', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String label, IconData icon, Color bgColor, Color textColor, {bool showBorder = false}) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: showBorder ? Border.all(color: AppColors.divider) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 24),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
