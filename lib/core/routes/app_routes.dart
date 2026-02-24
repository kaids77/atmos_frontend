import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/weather/presentation/pages/home_page.dart';
import '../../features/planner/presentation/pages/planner_page.dart';
import '../../features/ai_assistant/presentation/pages/ai_page.dart';
import '../../features/news/presentation/pages/news_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

class AppRoutes {
  static const splash = '/';
  static const signin = '/signin';
  static const signup = '/signup';
  static const home = '/home';
  static const planner = '/planner';
  static const ai = '/ai';
  static const news = '/news';
  static const settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),
    signin: (context) => const SignInPage(),
    signup: (context) => const SignUpPage(),
    home: (context) => const LandingPage(),
    planner: (context) => const PlannerPage(),
    ai: (context) => const AiPage(),
    news: (context) => const NewsPage(),
    settings: (context) => const SettingsPage(),
  };
}
